//
//  ViewController.m
//  CTWaveFlowDemo
//
//  Created by Admin on 2016/11/15.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "ViewController.h"
#import "CTWaveFlowView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;
@property (weak, nonatomic) IBOutlet UILabel *lab7;

@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider4;
@property (weak, nonatomic) IBOutlet UISlider *slider5;
@property (weak, nonatomic) IBOutlet UISlider *slider6;
@property (weak, nonatomic) IBOutlet UISlider *slider7;

@property (nonatomic, strong) CTWaveFlowView *waterView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.waterView = [[CTWaveFlowView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.waterView];
    [self.view sendSubviewToBack:_waterView];
    
    
    [self initWaveDefaultValue];
    
    [self initDefaultLableValue];
    
    [self initDefaultSilderValue];
    
    [_waterView addObserver:self forKeyPath:@"waveHigh" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    _lab1.text = [NSString stringWithFormat:@"waveHigh : %lf", _waterView.waveHigh];
    _slider1.value = _waterView.waveHigh;
}

#pragma mark 初始化波浪参数
- (void)initWaveDefaultValue
{
    //公式中用到
    _waterView.waveHigh = 10;
    //幅度增长速度
    _waterView.waveIncrease = 1;
    //减阈值
    _waterView.waveMinHigh = 4.0;
    //增阈值
    _waterView.waveMaxHigh = 5.5;
    //速度控制
    _waterView.waveSpeed = 0.08;
    //起始水深
    _waterView.waveDeep = 350;
    //起始浪宽
    _waterView.waveWidth = 180;
    
    _waterView.gradualEnable = NO;
    
    [_waterView startFlow];
}

- (void)initDefaultLableValue
{
    _lab1.text = [NSString stringWithFormat:@"waveHigh : %lf", _waterView.waveHigh];
    _lab2.text = [NSString stringWithFormat:@"waveIncrease :  %lf", _waterView.waveIncrease];
    _lab3.text = [NSString stringWithFormat:@"waveMinHigh :  %lf", _waterView.waveMinHigh];
    _lab4.text = [NSString stringWithFormat:@"waveMaxHigh :  %lf", _waterView.waveMaxHigh];
    _lab5.text = [NSString stringWithFormat:@"waveSpeed :  %lf", _waterView.waveSpeed];
    _lab6.text = [NSString stringWithFormat:@"waveDeep :  %lf", _waterView.waveDeep];
    _lab7.text = [NSString stringWithFormat:@"waveWidth :  %lf", _waterView.waveWidth];
}


- (void)initDefaultSilderValue
{
    _slider1.minimumValue = 10;
    _slider1.maximumValue = 50;
    _slider1.value = 10;
    
    _slider2.minimumValue = 0.5;
    _slider2.maximumValue = 5;
    _slider2.value = 1;
    
    _slider3.minimumValue = 10;
    _slider3.maximumValue = 50;
    _slider3.value = 4;
    
    _slider4.minimumValue = 10;
    _slider4.maximumValue = 50;
    _slider4.value = 5.5;
    
    _slider5.minimumValue = 0.01;
    _slider5.maximumValue = 0.1;
    _slider5.value = 0.08;
    
    _slider6.minimumValue = 10;
    _slider6.maximumValue = 400;
    _slider6.value = 350;
    
    _slider7.minimumValue = 10;
    _slider7.maximumValue = 400;
    _slider7.value = 180;
}

- (IBAction)valueChangeAction:(UISlider *)sender
{
    NSInteger index = sender.tag/100;
    NSLog(@"%lf, %ld", sender.value, index);
    UILabel * lab = [sender.superview viewWithTag:100];
    [self setValue:sender.value index:index lable:lab];
}

- (void)setValue:(CGFloat)value index:(NSInteger)index lable:(UILabel *)lab
{
    switch (index) {
        case 1:
        {
            _waterView.waveHigh = value;
            lab.text = [NSString stringWithFormat:@"waveHigh : %lf", value];
        }
            break;
        case 2:
        {
            _waterView.waveIncrease = value;
            lab.text = [NSString stringWithFormat:@"waveIncrease : %lf", value];
        }
            break;
        case 3:
        {
            _waterView.waveMinHigh = value;
            lab.text = [NSString stringWithFormat:@"waveMinHigh : %lf", value];
        }
            break;
        case 4:
        {
            _waterView.waveMaxHigh = value;
            lab.text = [NSString stringWithFormat:@"waveMaxHigh : %lf", value];
        }
            break;
        case 5:
        {
            _waterView.waveSpeed = value;
            lab.text = [NSString stringWithFormat:@"waveSpeed : %lf", value];
        }
            break;
        case 6:
        {
            _waterView.waveDeep = value;
            lab.text = [NSString stringWithFormat:@"waveDeep : %lf", value];
        }
            break;
        case 7:
        {
            _waterView.waveWidth = value;
            lab.text = [NSString stringWithFormat:@"waveWidth : %lf", value];
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
