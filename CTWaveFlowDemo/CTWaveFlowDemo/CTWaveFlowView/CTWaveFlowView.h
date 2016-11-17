//
//  CTWaveFlowView.h
//  CTWaveFlowDemo
//
//  Created by Admin on 2016/11/15.
//  Copyright © 2016年 Arvin. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CTWaveFlowView : UIView
// 水波纹颜色
@property (nonatomic, strong) UIColor * waveColor;
//浪高
@property (assign, nonatomic) float waveHigh;
//浪高渐变是否能用
@property (assign, nonatomic) BOOL  gradualEnable;
//幅度增长速度
@property (assign, nonatomic) float waveIncrease;
//幅度最小值
@property (assign, nonatomic) float waveMinHigh;
//幅度最大值
@property (assign, nonatomic) float waveMaxHigh;
//波浪增幅的速度控制
@property (assign, nonatomic) float waveSpeed;
//水深 
@property (assign, nonatomic) float waveDeep;
//浪宽
@property (assign, nonatomic) float waveWidth;

// 开始流动
- (void)startFlow;

// 释放前需要调用此方法, 否则不会释放
- (void)stopFlow;

@end
