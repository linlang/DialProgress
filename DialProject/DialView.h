//
//  ProgressBarView.h
//  LocalizationsProject
//
//  Created by Linyoung on 2017/7/27.
//  Copyright © 2017年 Linyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialView : UIView

@property (assign, nonatomic) float radius;//半径 最外层
@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) UIColor *normalColor;
@property (assign, nonatomic) float progress;//进度百分比
//@property (assign, nonatomic) BOOL animation;//是否开启动画
@property (assign, nonatomic) CGFloat calibrationWidth;//刻度的宽度

@property (strong, nonatomic) UIColor *circleLineColor;//圆圈线的颜色
@property (strong, nonatomic) UIColor *electricityBgColor;//电量背景色
@property (strong, nonatomic) UIColor *electricityColor;//电量背景色
//@property (assign, nonatomic) CGFloat electricityWidth;//电量宽度
@property (assign, nonatomic) CGFloat electricityPercentage;//电量百分比

- (id)initWithFrame:(CGRect)frame
             radius:(float)radius
      selectedColor:(UIColor *)selectedColor
        normalColor:(UIColor *)normalColor
           progress:(float)progress;


@end
