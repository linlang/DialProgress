//
//  ProgressBarView.m
//  LocalizationsProject
//
//  Created by Linyoung on 2017/7/27.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import "DialView.h"

@interface DialView ()

@property (strong, nonatomic) CAShapeLayer *calibrationLayer;//刻度选中
@property (strong, nonatomic) CAShapeLayer *calibrationNormalLayer;//刻度背景
@property (strong, nonatomic) CAReplicatorLayer *selectedReplicationLayer;
@property (strong, nonatomic) CAReplicatorLayer *normalReplicationLayer;
@property (assign, nonatomic) CGFloat openAngle;//开口的角度
@property (assign, nonatomic) int calibrationTotalNum;//刻度总个数

@property (strong, nonatomic) CAShapeLayer *circleLineLayer;
@property (strong, nonatomic) CAShapeLayer *electricityBgLayer;//电量背景图层
@property (strong, nonatomic) CAShapeLayer *electricityLayer;//电量颜色图层
@property (strong, nonatomic) CAShapeLayer *electricityBoardLayer;//电量外框

@end

@implementation DialView

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame radius:0 selectedColor:[UIColor whiteColor] normalColor:[UIColor colorWithWhite:1 alpha:0.5] progress:0];
}


- (id)initWithFrame:(CGRect)frame
             radius:(float)radius
      selectedColor:(UIColor *)selectedColor
        normalColor:(UIColor *)normalColor
           progress:(float)progress {
    if (self = [super initWithFrame:frame]) {
        [self initDefaultParameter];
        _radius = radius;
        _selectedColor = selectedColor;
        _normalColor = normalColor;
        _progress = progress;
        //        _animation = animation;
        [self createProgressLayers];
        [self createCircleLineLayer];
        [self createElectricityLayer];
    }
    return self;
}

- (void)initDefaultParameter {
    _circleLineColor = [UIColor colorWithWhite:1 alpha:0.7];
    _openAngle = 90;
    _calibrationWidth = 20;
    _calibrationTotalNum = 80;
    _electricityBgColor = [UIColor colorWithWhite:1 alpha:0.5];
    _electricityColor = [UIColor greenColor];
    //    _electricityWidth = _calibrationWidth-4;
    //测试数据
    _electricityPercentage = 0.8;
}

- (void)createProgressLayers {
    [self configProgressNormalLayer];
    [self configProgressSelectedLayer];
    [self.layer addSublayer:self.normalReplicationLayer];
    [self.layer addSublayer:self.selectedReplicationLayer];
}

//创建进度刻度条

- (void)configProgressNormalLayer {
    //刻度正常情况下
    //中心点的半径
    float progressCenterRadius = _radius - _calibrationWidth/2.0;
    //左边第一个刻度
    float beginAngel = 360-_openAngle/2.0;
    self.calibrationNormalLayer.bounds = CGRectMake(0, 0, 3, _calibrationWidth);
    float x = sin(beginAngel/180.0*M_PI)*progressCenterRadius+CGRectGetWidth(self.bounds)/2.0;
    float y = cos(beginAngel/180.0*M_PI)*progressCenterRadius+CGRectGetHeight(self.bounds)/2.0;
    self.calibrationNormalLayer.position = CGPointMake(x,y);
    self.calibrationNormalLayer.transform = CATransform3DMakeRotation((beginAngel-90)/360*(M_PI*2), 0, 0, 1);
    
    [self.normalReplicationLayer addSublayer:self.calibrationNormalLayer];
    self.normalReplicationLayer.instanceCount = _calibrationTotalNum;
    self.normalReplicationLayer.instanceDelay = 0.3;
    float angle = (360-_openAngle)/360.0*(M_PI*2)/(_calibrationTotalNum-1);
    self.normalReplicationLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
}

- (void)configProgressSelectedLayer {
    //中心点的半径
    float progressCenterRadius = _radius - _calibrationWidth/2.0;
    //左边第一个刻度
    float beginAngel = 360-_openAngle/2.0;
    self.calibrationLayer.bounds = CGRectMake(0, 0, 3, _calibrationWidth);
    float x = sin(beginAngel/180.0*M_PI)*progressCenterRadius+CGRectGetWidth(self.bounds)/2.0;
    float y = cos(beginAngel/180.0*M_PI)*progressCenterRadius+CGRectGetHeight(self.bounds)/2.0;
    self.calibrationLayer.position = CGPointMake(x,y);
    self.calibrationLayer.transform = CATransform3DMakeRotation((beginAngel-90)/360*(M_PI*2), 0, 0, 1);
    
    [self.selectedReplicationLayer addSublayer:self.calibrationLayer];
    self.selectedReplicationLayer.instanceCount = _calibrationTotalNum*_progress;
    self.selectedReplicationLayer.instanceDelay = 0.3;
    float angle = (360-_openAngle)/360.0*(M_PI*2)/(_calibrationTotalNum-1);
    self.selectedReplicationLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
}

- (void)configProgressNormalColor {
    self.calibrationNormalLayer.backgroundColor = _normalColor.CGColor;
}

- (void)configProgressSelectedColor {
    self.calibrationLayer.backgroundColor = _selectedColor.CGColor;
}

//刻度条白色的线

- (void)configCircleLineLayer {
    float beginAngel = 90+_openAngle/2.0;
    float endAngel =90-_openAngle/2.0;
    float radius = _radius - _calibrationWidth - 5;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)*0.5, CGRectGetHeight(self.bounds) * 0.5) radius:radius startAngle:(beginAngel/360.0)*2*M_PI endAngle:0.5*M_PI-(endAngel/180.0)*M_PI clockwise:YES];
    self.circleLineLayer.path = path.CGPath;
}
- (void)createCircleLineLayer {
    [self configCircleLineLayer];
    [self.layer addSublayer:self.circleLineLayer];
}

//电量
- (void)configElectricityBgLayer {
    //电量背景
    float openAngle = _openAngle - 20;
    if (openAngle <= 0) {
        return;
    }
    float radius = _radius - _calibrationWidth+ (_calibrationWidth-4)/2.0;
    
    float beginAngel = 90+openAngle/2.0;
    float bgEndAngel = 90-openAngle/2.0;
    
    //电量背景
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)*0.5, CGRectGetHeight(self.bounds) * 0.5) radius:radius startAngle:(beginAngel/180.0)*M_PI endAngle:(bgEndAngel/180.0)*M_PI clockwise:NO];
    self.electricityBgLayer.lineWidth = _calibrationWidth-4;
    self.electricityBgLayer.path = bgPath.CGPath;
}

- (void)configElectricityBgColor {
    self.electricityBgLayer.strokeColor = _electricityBgColor.CGColor;
}

- (void)configElectricityLayer {
    float openAngle = _openAngle - 20;
    if (openAngle <= 0) {
        return;
    }
    float radius = _radius - _calibrationWidth+ (_calibrationWidth-4)/2.0;
    
    float beginAngel = 90+openAngle/2.0;
    float endAngel = beginAngel - openAngle*_electricityPercentage;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)*0.5, CGRectGetHeight(self.bounds) * 0.5) radius:radius startAngle:(beginAngel/180.0)*M_PI endAngle:(endAngel/180.0)*M_PI clockwise:NO];
    self.electricityLayer.lineWidth = _calibrationWidth-4;
    self.electricityLayer.path = path.CGPath;
}

- (void)configElectricityColor {
    self.electricityLayer.strokeColor = _electricityColor.CGColor;
}

- (void)configElectricityBoardLayer {
    //电量外框
    float openAngle = _openAngle - 20;
    if (openAngle <= 0) {
        return;
    }
    CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0);
    float boardOpenAngle = openAngle+4;
    float boardBeginAngel = 270-boardOpenAngle/2.0;//画直线的角度
    //    float boardEndAngel = -(90-boardOpenAngle/2.0);//画直线的角度
    float boardArcBeginAngel = 90+boardOpenAngle/2.0;//画弧线的角度
    float boardArcEndAngel = 90-boardOpenAngle/2.0;
    float leftBeginX = cos(boardBeginAngel/180.0*M_PI)*(_radius-_calibrationWidth)+CGRectGetWidth(self.frame)/2.0;
    float leftBeginY = -sin(boardBeginAngel/180.0*M_PI)*(_radius-_calibrationWidth)+CGRectGetHeight(self.frame)/2.0;
    float leftEndX = cos(boardBeginAngel/180.0*M_PI)*(_radius)+CGRectGetWidth(self.frame)/2.0;
    float leftEndY = -sin(boardBeginAngel/180.0*M_PI)*(_radius)+CGRectGetHeight(self.frame)/2.0;
    UIBezierPath *boardPath = [UIBezierPath bezierPath];
    [boardPath moveToPoint:CGPointMake(leftBeginX,leftBeginY)];
    [boardPath addLineToPoint:CGPointMake(leftEndX,leftEndY)];
    [boardPath addArcWithCenter:centerPoint radius:_radius startAngle:boardArcBeginAngel/180.0*M_PI endAngle:boardArcEndAngel/180.0*M_PI clockwise:NO];
    
    [boardPath addLineToPoint:CGPointMake(cos(boardArcEndAngel/180.0*M_PI)*(_radius-_calibrationWidth)+centerPoint.x, sin(boardArcEndAngel/180.0*M_PI)*(_radius-_calibrationWidth)+centerPoint.y)];
    self.electricityBoardLayer.path = boardPath.CGPath;
    
}

- (void)createElectricityLayer {
    
    [self configElectricityBgLayer];
    [self configElectricityLayer];
    [self configElectricityBoardLayer];
    [self.layer addSublayer:self.electricityBgLayer];
    [self.layer addSublayer:self.electricityLayer];
    [self.layer addSublayer:self.electricityBoardLayer];
}



#pragma mark - set and get

- (CAShapeLayer *)calibrationLayer {
    if (_calibrationLayer == nil) {
        _calibrationLayer = [CAShapeLayer layer];
        _calibrationLayer.backgroundColor = _selectedColor.CGColor;
        _calibrationLayer.allowsEdgeAntialiasing = YES;
    }
    return _calibrationLayer;
}

- (CAShapeLayer *)calibrationNormalLayer {
    if (_calibrationNormalLayer == nil) {
        _calibrationNormalLayer = [CAShapeLayer layer];
        _calibrationNormalLayer.backgroundColor = _normalColor.CGColor;
        _calibrationNormalLayer.allowsEdgeAntialiasing = YES;
    }
    return _calibrationNormalLayer;
}

- (CAReplicatorLayer *)selectedReplicationLayer {
    if (_selectedReplicationLayer == nil) {
        _selectedReplicationLayer = [CAReplicatorLayer layer];
        _selectedReplicationLayer.frame = self.bounds;
    }
    return _selectedReplicationLayer;
}

- (CAReplicatorLayer *)normalReplicationLayer {
    if (_normalReplicationLayer == nil) {
        _normalReplicationLayer = [CAReplicatorLayer layer];
        _normalReplicationLayer.frame = self.bounds;
    }
    return _normalReplicationLayer;
}



- (CAShapeLayer *)circleLineLayer {
    if (_circleLineLayer == nil) {
        _circleLineLayer = [CAShapeLayer layer];
        _circleLineLayer.strokeColor = _circleLineColor.CGColor;
        _circleLineLayer.lineWidth = 2;
        _circleLineLayer.backgroundColor = [UIColor clearColor].CGColor;
        _circleLineLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _circleLineLayer;
}

- (CAShapeLayer *)electricityLayer {
    if (_electricityLayer == nil) {
        _electricityLayer = [CAShapeLayer layer];
        _electricityLayer.strokeColor = _electricityColor.CGColor;
        _electricityLayer.lineWidth = _calibrationWidth-4;
        _electricityLayer.fillColor = [UIColor clearColor].CGColor;
        _electricityLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _electricityLayer;
}

- (CAShapeLayer *)electricityBgLayer {
    if (_electricityBgLayer == nil) {
        _electricityBgLayer = [CAShapeLayer layer];
        _electricityBgLayer.strokeColor = _electricityBgColor.CGColor;
        _electricityBgLayer.lineWidth = _calibrationWidth-4;
        _electricityBgLayer.fillColor = [UIColor clearColor].CGColor;
        _electricityBgLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _electricityBgLayer;
}

- (CAShapeLayer *)electricityBoardLayer {
    if (_electricityBoardLayer == nil) {
        _electricityBoardLayer = [CAShapeLayer layer];
        _electricityBoardLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
        _electricityBoardLayer.fillColor = [UIColor clearColor].CGColor;
        _electricityBoardLayer.backgroundColor = [UIColor clearColor].CGColor;
        _electricityBoardLayer.lineWidth = 3;
    }
    return _electricityBoardLayer;
}

- (void)setRadius:(float)radius {
    _radius = radius;
    //半径 重新画整个
    [self configProgressNormalLayer];
    [self configProgressSelectedLayer];
    [self configCircleLineLayer];
    [self configElectricityBgLayer];
    [self configElectricityLayer];
    [self configElectricityBoardLayer];
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    //刻度选中颜色 重新设置刻度选中颜色
    [self configProgressSelectedColor];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    //刻度背景色 重新设置刻度背景色
    [self configProgressNormalColor];
}

- (void)setProgress:(float)progress {
    if (progress > 1 ) {
        progress = 1;
    }
    if (progress < 0) {
        progress = 0;
    }
    _progress = progress;
    //设置进度条 刻度选中图层
    [self configProgressSelectedLayer];
}

- (void)setCalibrationWidth:(CGFloat)calibrationWidth {
    _calibrationWidth = calibrationWidth;
    //刻度的宽度 重新画刻度背景跟选中 还有电量
    [self configProgressNormalLayer];
    [self configProgressSelectedLayer];
    [self configCircleLineLayer];
    [self configElectricityBgLayer];
    [self configElectricityLayer];
    [self configElectricityBoardLayer];
}

- (void)setCircleLineColor:(UIColor *)circleLineColor {
    _circleLineColor = circleLineColor;
    //圆圈线的颜色 重画圆圈线
    [self configCircleLineLayer];
}

- (void)setElectricityBgColor:(UIColor *)electricityBgColor {
    _electricityBgColor = electricityBgColor;
    //电量背景色 重新绘制电量
    [self configElectricityBgColor];
}

- (void)setElectricityColor:(UIColor *)electricityColor {
    _electricityColor = electricityColor;
    //电量颜色 重新绘制电量
    [self configElectricityColor];
}

- (void)setElectricityPercentage:(CGFloat)electricityPercentage {
    if (electricityPercentage > 1) {
        electricityPercentage = 1;
    }
    if (electricityPercentage < 0) {
        electricityPercentage = 0;
    }
    _electricityPercentage = electricityPercentage;
    //电量百分比 设置电量
    [self configElectricityLayer];
}






@end
