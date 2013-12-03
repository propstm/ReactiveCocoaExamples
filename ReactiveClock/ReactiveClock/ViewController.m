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
    
    [self rac_liftSelector:@selector(updateHands:) withSignals:dateComponentsSignal, nil];
    
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
    
    [self setupClockFace];
    
}

-(void)setupClockFace
{
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(10,20,260,260)];
    circleView.alpha = 0.5;
    circleView.layer.cornerRadius = 125;
    circleView.backgroundColor = [UIColor blueColor];
    [circleView setCenter:self.view.center];
    [self.view addSubview:circleView];
    
    
    self.hourHand = [[ClockHandView alloc] initWithFrame:CGRectMake(25, 125, 175, 175) handType:2];
    [self.hourHand setCenter:self.view.center];
    self.minuteHand = [[ClockHandView alloc] initWithFrame:CGRectMake(25, 125, 250, 250) handType:1];
    [self.minuteHand setCenter:self.view.center];
    self.secondHand = [[ClockHandView alloc] initWithFrame:CGRectMake(25, 125, 250, 250) handType:0];
    [self.secondHand setCenter:self.view.center];
    
    [self.view addSubview:self.hourHand];
    [self.view addSubview:self.minuteHand];
    [self.view addSubview:self.secondHand];
}

-(void) updateHands:(NSDateComponents*)dc
{
    double hourTime = dc.hour;
    if(hourTime > 12){
        hourTime = hourTime - 12;
    }
    [self.hourHand setDegreeAngle:hourTime * 30];
	[self.hourHand setNeedsDisplay];
    
    [self.minuteHand setDegreeAngle:dc.minute * 6];
	[self.minuteHand setNeedsDisplay];
    
    
    [self.secondHand setDegreeAngle:dc.second*6];
	[self.secondHand setNeedsDisplay];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
