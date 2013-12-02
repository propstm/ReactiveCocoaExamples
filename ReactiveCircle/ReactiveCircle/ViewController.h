//
//  ViewController.h
//  ReactiveCircle
//
//  Created by Matthew Propst on 12/2/13.
//  Copyright (c) 2013 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController : UIViewController
@property (strong) UIView *circleView;
@property (strong) UITextField *hourTextField;
@property (strong) UITextField *minuteTextField;
@property (strong) UITextField *secondTextField;
@end
