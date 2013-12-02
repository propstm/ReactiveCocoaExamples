//
//  ViewController.h
//  ReactiveForm
//
//  Created by Matthew Propst on 12/2/13.
//  Copyright (c) 2013 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (strong) UITextField *namefield;
@property (strong) UITextField *passwordfield;
@property (strong) UITextField *emailfield;
@property (strong) UILabel *isValidNameLabel;
@property (strong) UILabel *isValidPasswordLabel;
@property (strong) UILabel *isValidEmailLabel;

@property (strong) RACSignal *nameSignal;
@property (strong) RACSignal *emailSignal;
@property (strong) RACSignal *passwordSignal;


@end
