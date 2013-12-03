//
//  ClockHandView.h
//  ReactiveCircle
//
//  Created by Matthew Propst on 12/3/13.
//  Copyright (c) 2013 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>

//TODO: should be an enum
//#define secondHand = 0;
//#define minuteHand = 1;
//#define hourHand = 2;

typedef enum {
	SecondHandEnum = 0,
	MinuteHandEnum,
    HourHandEnum
} HandEnum;

@interface ClockHandView : UIView{
    int clockHandType;
    NSInteger radiusCount;
	double degreeAngle;
    HandEnum currentHandMode;
	UIColor *currentHandColor;
}
@property (assign) double degreeAngle;
- (id)initWithFrame:(CGRect)frame handType:(int)type;
- (CGPoint) getPointOfCircleFromAngle:(double)angle andCenterPoint:(CGPoint)centerPoint andRadias:(double)radias;
- (void)drawRect:(CGRect)rect withAngle:(NSDateComponents*)components;
@end
