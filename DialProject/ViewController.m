//
//  ViewController.m
//  DialProject
//
//  Created by Linyoung on 2017/7/28.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import "ViewController.h"
#import "DialView.h"


@interface ViewController ()

@property (strong, nonatomic) DialView *dialView;
@property (strong, nonatomic) UIButton *radiusBtn;//修改半径
@property (strong, nonatomic) UIButton *selectedColorBtn;//设置刻度选中颜色
@property (strong, nonatomic) UIButton *normalColorBtn;//设置刻度平常时的颜色
@property (strong, nonatomic) UIButton *calibrationWidthBtn;//设置刻度的宽度按钮
@property (strong, nonatomic) UIButton *electricityBgColorBtn;//修改电量背景颜色
@property (strong, nonatomic) UIButton *electricityColorBtn;//修改电量颜色
@property (strong, nonatomic) UIButton *calibrationBtn;//修改刻度按钮
@property (strong, nonatomic) UIButton *electricityBtn;//修改电量

@property (assign, nonatomic) BOOL isAdd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methords

- (void)createSubView {
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.dialView = [[DialView alloc] initWithFrame:CGRectMake((screenWidth-300)/2.0, 30, 300, 300) radius:90 selectedColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.5] normalColor:[UIColor colorWithWhite:1 alpha:1] progress:0.3];
    self.dialView.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:107.0/255.0 blue:98.0/255.0 alpha:1];
    [self.view addSubview:self.dialView];
    
    float btnWidth = 100;
    float btnHeight = 45;
    
    float horizontalInterval = (screenWidth-3*btnWidth)/4.0;//水平间隔
    float verticalInterval = 15;
    
    self.radiusBtn.frame = CGRectMake(horizontalInterval , CGRectGetMaxY(self.dialView.frame)+20, btnWidth, btnHeight);
    self.selectedColorBtn.frame = CGRectMake(horizontalInterval+1*(horizontalInterval+btnWidth) , CGRectGetMaxY(self.dialView.frame)+20, btnWidth, btnHeight);
    self.normalColorBtn.frame = CGRectMake(horizontalInterval+2*(horizontalInterval+btnWidth) , CGRectGetMaxY(self.dialView.frame)+20, btnWidth, btnHeight);
    
    self.calibrationWidthBtn.frame = CGRectMake(horizontalInterval , CGRectGetMaxY(self.dialView.frame)+20+(btnHeight+verticalInterval), btnWidth, btnHeight);
    
    self.electricityBgColorBtn.frame = CGRectMake(horizontalInterval+1*(horizontalInterval+btnWidth) , CGRectGetMaxY(self.dialView.frame)+20+(btnHeight+verticalInterval), btnWidth, btnHeight);
    self.electricityColorBtn.frame = CGRectMake(horizontalInterval+2*(horizontalInterval+btnWidth) , CGRectGetMaxY(self.dialView.frame)+20+(btnHeight+verticalInterval), btnWidth, btnHeight);
    
    self.calibrationBtn.frame = CGRectMake(horizontalInterval , CGRectGetMaxY(self.dialView.frame)+20+(btnHeight+verticalInterval)*2, btnWidth, btnHeight);
    self.electricityBtn.frame = CGRectMake(horizontalInterval+1*(horizontalInterval+btnWidth) , CGRectGetMaxY(self.dialView.frame)+20+(btnHeight+verticalInterval)*2, btnWidth, btnHeight);
    
    [self.view addSubview:self.radiusBtn];
    [self.view addSubview:self.selectedColorBtn];
    [self.view addSubview:self.normalColorBtn];
    [self.view addSubview:self.calibrationWidthBtn];
    [self.view addSubview:self.electricityBgColorBtn];
    [self.view addSubview:self.electricityColorBtn];
    [self.view addSubview:self.calibrationBtn];
    [self.view addSubview:self.electricityBtn];
}


#pragma mark - event response

- (void)changeRadius:(UIButton *)sender {
    //修改半径
    float radius = self.dialView.radius;
    radius += 5;
    if (radius > MIN(CGRectGetWidth(self.dialView.bounds)/2.0, CGRectGetHeight(self.dialView.bounds)/2.0)) {
        radius = 30;
    }
    self.dialView.radius = radius;
}

- (void)changeSelectedColor:(UIButton *)sender {
    //修改刻度颜色
    float r = arc4random()%255 / 255.0;
    float g = arc4random()%255 / 255.0;
    float b = arc4random()%255 / 255.0;
    self.dialView.selectedColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)changeNormalColor:(UIButton *)sender {
    //修改刻度背景色
    float r = arc4random()%255 / 255.0;
    float g = arc4random()%255 / 255.0;
    float b = arc4random()%255 / 255.0;
    self.dialView.normalColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)changeCalibrationWidth:(UIButton *)sender {
    //修改刻度宽度
    float width = self.dialView.calibrationWidth;
    width += 5;
    if (width>50) {
        width = 0;
    }
    self.dialView.calibrationWidth = width;
}

- (void)changeElectricityBgColor:(UIButton *)sender {
    //修改电量背景色
    float r = arc4random()%255 / 255.0;
    float g = arc4random()%255 / 255.0;
    float b = arc4random()%255 / 255.0;
    self.dialView.electricityBgColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)changeElectricityColor:(UIButton *)sender {
    //修改电量颜色
    float r = arc4random()%255 / 255.0;
    float g = arc4random()%255 / 255.0;
    float b = arc4random()%255 / 255.0;
    self.dialView.electricityColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)changeCalibration:(UIButton *)sender {
    //修改刻度百分比
    float progress = self.dialView.progress;
    progress += 0.1;
    if (progress >= 1) {
        progress = 0;
    }
    self.dialView.progress = progress;
}

- (void)changeElectricity:(UIButton *)sender {
    //修改电量百分比
    float electricity = self.dialView.electricityPercentage;
    electricity += 0.1;
    if (electricity >= 1) {
        electricity = 0;
    }
    self.dialView.electricityPercentage = electricity;
}



#pragma mark - set and get

- (UIButton *)radiusBtn {
    if (_radiusBtn == nil) {
        _radiusBtn = [[UIButton alloc] init];
        _radiusBtn.layer.cornerRadius = 5;
        _radiusBtn.layer.masksToBounds = YES;
        [_radiusBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_radiusBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_radiusBtn setTitle:@"修改半径" forState:UIControlStateNormal];
        [_radiusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _radiusBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_radiusBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]];
        
        [_radiusBtn addTarget:self action:@selector(changeRadius:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _radiusBtn;
}

- (UIButton *)selectedColorBtn {
    if (_selectedColorBtn == nil) {
        _selectedColorBtn = [[UIButton alloc] init];
        _selectedColorBtn.layer.cornerRadius = 5;
        _selectedColorBtn.layer.masksToBounds = YES;
        [_selectedColorBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_selectedColorBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_selectedColorBtn setTitle:@"修改刻度颜色" forState:UIControlStateNormal];
        [_selectedColorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectedColorBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_selectedColorBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]];
        
        [_selectedColorBtn addTarget:self action:@selector(changeSelectedColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedColorBtn;
}

- (UIButton *)normalColorBtn {
    if (_normalColorBtn == nil) {
        _normalColorBtn = [[UIButton alloc] init];
        _normalColorBtn.layer.cornerRadius = 5;
        _normalColorBtn.layer.masksToBounds = YES;
        [_normalColorBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_normalColorBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_normalColorBtn setTitle:@"修改刻度背景色" forState:UIControlStateNormal];
        [_normalColorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _normalColorBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_normalColorBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]];
        
        [_normalColorBtn addTarget:self action:@selector(changeNormalColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _normalColorBtn;
}

- (UIButton *)calibrationWidthBtn {
    if (_calibrationWidthBtn == nil) {
        _calibrationWidthBtn = [[UIButton alloc] init];
        _calibrationWidthBtn.layer.cornerRadius = 5;
        _calibrationWidthBtn.layer.masksToBounds = YES;
        [_calibrationWidthBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_calibrationWidthBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_calibrationWidthBtn setTitle:@"修改刻度宽度" forState:UIControlStateNormal];
        [_calibrationWidthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _calibrationWidthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_calibrationWidthBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]];
        
        [_calibrationWidthBtn addTarget:self action:@selector(changeCalibrationWidth:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calibrationWidthBtn;
}

- (UIButton *)electricityBgColorBtn {
    if (_electricityBgColorBtn == nil) {
        _electricityBgColorBtn = [[UIButton alloc] init];
        _electricityBgColorBtn.layer.cornerRadius = 5;
        _electricityBgColorBtn.layer.masksToBounds = YES;
        [_electricityBgColorBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_electricityBgColorBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_electricityBgColorBtn setTitle:@"修改电量背景色" forState:UIControlStateNormal];
        [_electricityBgColorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _electricityBgColorBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_electricityBgColorBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]];
        
        [_electricityBgColorBtn addTarget:self action:@selector(changeElectricityBgColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _electricityBgColorBtn;
}

- (UIButton *)electricityColorBtn {
    if (_electricityColorBtn == nil) {
        _electricityColorBtn = [[UIButton alloc] init];
        _electricityColorBtn.layer.cornerRadius = 5;
        _electricityColorBtn.layer.masksToBounds = YES;
        [_electricityColorBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_electricityColorBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_electricityColorBtn setTitle:@"修改电量颜色" forState:UIControlStateNormal];
        [_electricityColorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _electricityColorBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_electricityColorBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]];
        
        [_electricityColorBtn addTarget:self action:@selector(changeElectricityColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _electricityColorBtn;
}


- (UIButton *)calibrationBtn {
    if (_calibrationBtn == nil) {
        _calibrationBtn = [[UIButton alloc] init];
        _calibrationBtn.layer.cornerRadius = 5;
        _calibrationBtn.layer.masksToBounds = YES;
        [_calibrationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_calibrationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_calibrationBtn setTitle:@"修改刻度" forState:UIControlStateNormal];
        [_calibrationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _calibrationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_calibrationBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]];
        
        [_calibrationBtn addTarget:self action:@selector(changeCalibration:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calibrationBtn;
}

- (UIButton *)electricityBtn {
    if (_electricityBtn == nil) {
        _electricityBtn = [[UIButton alloc] init];
        _electricityBtn.layer.cornerRadius = 5;
        _electricityBtn.layer.masksToBounds = YES;
        [_electricityBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_electricityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_electricityBtn setTitle:@"修改电量" forState:UIControlStateNormal];
        [_electricityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _electricityBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_electricityBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1]];
        
        [_electricityBtn addTarget:self action:@selector(changeElectricity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _electricityBtn;
}



@end
