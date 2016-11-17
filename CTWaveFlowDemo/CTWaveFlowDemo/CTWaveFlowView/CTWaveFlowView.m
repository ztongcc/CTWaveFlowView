//
//  CTWaveFlowView.m
//  CTWaveFlowDemo
//
//  Created by Admin on 2016/11/15.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "CTWaveFlowView.h"

@interface CTWaveFlowView ()

@property (assign, nonatomic) BOOL addFlag;

//公式中用到(起始相位)
@property (assign, nonatomic) float phase;

@property (nonatomic, strong) NSTimer * timer;

@end


@implementation CTWaveFlowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        //公式中用到(起始速度)
        [self initBasicSet];
    }
    return self;
}

- (void)startFlow
{
    [self.timer setFireDate:[NSDate date]];
}

- (void)stopFlow
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)initBasicSet
{
    self.phase = 0;
    self.gradualEnable = YES;
    self.waveColor = [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
}

- (void)animateWave
{
    if (self.gradualEnable)
    {
        if (self.waveMinHigh < self.waveMaxHigh)
        {
            if (self.addFlag == YES)
            {
                self.waveHigh += self.waveIncrease;
                self.waveHigh = (self.waveHigh < self.waveMinHigh ? self.waveMinHigh : self.waveHigh);
            }
            else
            {
                self.waveHigh -= self.waveIncrease;
                self.waveHigh = (self.waveHigh > self.waveMaxHigh ? self.waveMaxHigh: self.waveHigh);
            }
            
            if (self.waveHigh <= self.waveMinHigh) {
                self.addFlag = YES;
            }
            
            if (self.waveHigh >= self.waveMaxHigh) {
                self.addFlag = NO;
            }
        }
        else
        {
            self.gradualEnable = NO;
        }
    }
  
    
    self.phase += self.waveSpeed;
    
    //该方法会重新调用drawRect方法
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat width  = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [_waveColor CGColor]);
    
    // 控制水深
    if (self.waveDeep <= 0 || self.waveDeep >= height)
    {
        self.waveDeep = height/2.0;
    }
    float y = height - self.waveDeep;
   
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x = 0; x<= width; x++)
    {
        y = self.waveHigh * sin(x/self.waveWidth * M_PI + 4 * self.phase/M_PI) + height - self.waveDeep;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    //左上到右下颜色填充
    CGPathAddLineToPoint(path, nil, width, rect.size.height);
    //右上到左下颜色填充
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    //暂未发现有什么用
    CGPathAddLineToPoint(path, nil, 0, height - self.waveDeep);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                  target:self
                                                selector:@selector(animateWave)
                                                userInfo:nil
                                                 repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}
@end
