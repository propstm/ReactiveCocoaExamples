//
//  ViewController.h
//  ReactiveCircle
//
//  Created by Matthew Propst on 12/2/13.
//  Copyright (c) 2013 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <ReactiveCocoa/ReactiveCocoa.h>
#import "ClockHandView.h"

@interface ViewController : UIViewController

@property (strong) ClockHandView *secondHand;
@property (strong) ClockHandView *minuteHand;
@property (strong) ClockHandView *hourHand;
@property (strong) UITextField *hourTextField;
@property (strong) UITextField *minuteTextField;
@property (strong) UITextField *secondTextField;
@property (strong) NSTimer *startDrawArcAnimationTimer;

@end
