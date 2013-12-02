//
//  ViewController.m
//  ReactiveCircle
//
//  Created by Matthew Propst on 12/2/13.
//  Copyright (c) 2013 Matthew Propst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
double oldValue;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hourTextField   = [[UITextField alloc] initWithFrame:CGRectMake(120, 15, 30, 30)];
    self.minuteTextField = [[UITextField alloc] initWithFrame:CGRectMake(155, 15, 30, 30)];
    self.secondTextField = [[UITextField alloc] initWithFrame:CGRectMake(185, 15, 30, 30)];
    [self.view addSubview:self.hourTextField];
    [self.view addSubview:self.minuteTextField];
    [self.view addSubview:self.secondTextField];
    
    
    RACSignal *dateComponentsSignal = [[[RACSignal interval:1 onScheduler:RACScheduler.mainThreadScheduler] startWith:[NSDate date]] map:^id(NSDate *value) {
        NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:value];
        return dateComponents;
    }];

    [self rac_liftSelector:@selector(scaleCircleFrom:) withSignals:dateComponentsSignal, nil];
    
    RAC(self.hourTextField, text) = [dateComponentsSignal map:^id(NSDateComponents *dateComponents) {
        NSLog(@"date component hour: %d", dateComponents.hour);
        return [NSString stringWithFormat:@"%d :", dateComponents.hour];
    }];
    
    RAC(self.minuteTextField, text) = [dateComponentsSignal map:^id(NSDateComponents *dateComponents) {
        return [NSString stringWithFormat:@"%d :", dateComponents.minute];
    }];
    
    RAC(self.secondTextField, text) = [dateComponentsSignal map:^id(NSDateComponents *dateComponents) {
        return [NSString stringWithFormat:@"%d", dateComponents.second];
    }];
    
}

- (void)scaleCircleFrom:(NSDateComponents *)dc
{
    if(!self.circleView){
        self.circleView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 250, 6, 6)];
    }
    self.circleView.backgroundColor = [UIColor blueColor];
    self.circleView.layer.cornerRadius = 3;
    
    [self.view addSubview:self.circleView];
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1.0;
    //scaleAnimation.autoreverses = YES;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:dc.second-1];
    scaleAnimation.toValue = [NSNumber numberWithFloat:dc.second];
    [self.circleView.layer addAnimation:scaleAnimation forKey:@"scale"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
