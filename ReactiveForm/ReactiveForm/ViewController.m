//
//  ViewController.m
//  ReactiveForm
//
//  Created by Matthew Propst on 12/2/13.
//  Copyright (c) 2013 Matthew Propst. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [self setupUI];
    
    [self setupRACSignaling];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)setupUI{
    //BUILD UI
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 80, 30)];
    [nameLabel setText:@"Name"];
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 70, 80, 30)];
    [emailLabel setText:@"Email"];
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 110, 80, 30)];
    [passwordLabel setText:@"Password"];
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 155, 100, 30)];
    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor blueColor]];
    
    self.namefield = [[UITextField alloc] initWithFrame:CGRectMake(125, 25, 100, 30)];
    [self.namefield setBackgroundColor:[UIColor grayColor]];
    self.emailfield = [[UITextField alloc] initWithFrame:CGRectMake(125, 70, 100, 30)];
    [self.emailfield setBackgroundColor:[UIColor grayColor]];
    self.passwordfield = [[UITextField alloc] initWithFrame:CGRectMake(125, 110, 100, 30)];
    [self.passwordfield setBackgroundColor:[UIColor grayColor]];
    
    [self.namefield setDelegate:self];
    [self.emailfield setDelegate:self];
    [self.passwordfield setDelegate:self];
    
    self.isValidNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 25, 100, 30)];
    self.isValidEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 70, 100, 30)];
    self.isValidPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 110, 100, 30)];
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:emailLabel];
    [self.view addSubview:passwordLabel];
    //Removing this from the UI because i'm not using it for anything currently.
    //[self.view addSubview:loginBtn];
    
    [self.view addSubview:self.namefield];
    [self.view addSubview:self.emailfield];
    [self.view addSubview:self.passwordfield];
    
    [self.view addSubview:self.isValidNameLabel];
    [self.view addSubview:self.isValidEmailLabel];
    [self.view addSubview:self.isValidPasswordLabel];
}

- (void)setupRACSignaling{
    [self addSignals];
    [self addSignalResponses];
}

-(void)addSignals{
    //Add RACSignals to monitor the values of the textfields
    self.nameSignal = [self.namefield.rac_textSignal map:^id(id value) {
        return @([value length] > 3);
    }];
    
    self.emailSignal = [self.emailfield.rac_textSignal map:^id(id value) {
        return @([value length] > 4 && [value rangeOfString:@"@"].location != NSNotFound);
    }];
    
    self.passwordSignal = [self.passwordfield.rac_textSignal map:^id(id value) {
        return @([value length] > 4);
    }];
}

-(void)addSignalResponses{
    // RAC macro takes at least two params - object and keypath you are binding.
    // source: http://stackoverflow.com/questions/20266886/enabling-an-uibutton-using-reactive-cocoa-racsignal
    
    RAC(self.isValidNameLabel, text) = [self.nameSignal map:^id(id value) {
        if([value boolValue]){
            return @"Valid";
        }else{
            return @"Invalid";
        }
    }];
    
    RAC(self.isValidEmailLabel, text) = [self.nameSignal map:^id(id value) {
        if([value boolValue]){
            return @"Valid";
        }else{
            return @"Invalid";
        }
    }];
    
    RAC(self.isValidPasswordLabel, text) = [self.nameSignal map:^id(id value) {
        if([value boolValue]){
            return @"Valid";
        }else{
            return @"Invalid";
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
