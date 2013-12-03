//
//  ClockHandView.m
//  ReactiveCircle
//
//  Created by Matthew Propst on 12/3/13.
//  Copyright (c) 2013 Matthew Propst. All rights reserved.
//

#import "ClockHandView.h"
#import <QuartzCore/QuartzCore.h>

#define ksecondHandColor		[UIColor greenColor]
#define kminuteHandColor		[UIColor blueColor]

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180 / M_PI;};

@implementation ClockHandView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
		//currentMode = ArcFirstColorMode;
		currentHandColor = ksecondHandColor;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame handType:(int)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        switch(type){
            case 0:
                currentHandMode = 0;
                currentHandColor = [UIColor grayColor];
            break;
            case 1:
                currentHandMode = 1;
                                currentHandColor = [UIColor blueColor];
            break;
            case 2:
                currentHandMode = 2;
                                currentHandColor = [UIColor blackColor];
            break;
                
        }
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
	NSLog(@"ArcView drawRect");
    NSLog(@"Degree angle: %f", degreeAngle);
    NSLog(@"Degree angle: %f", _degreeAngle);
    _degreeAngle = _degreeAngle - 90;
    
//    NSLog(@"SUPER TEXTFIELD: %@ <-- value", secondTextField.text);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[[self layer] renderInContext:context];
	
	CGPoint centerPoint;
	centerPoint.x = [self bounds].size.width/2;
	centerPoint.y = [self bounds].size.height/2;
	double radias = [self bounds].size.width/2;
	
	if(_degreeAngle >= 360){
		_degreeAngle = 0;
	}
    //degreeAngle = 270;
    
	double angle = DegreesToRadians(_degreeAngle);
	
	//For CenterPint
	CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
	CGContextMoveToPoint(context, centerPoint.x, centerPoint.y);
	CGContextAddEllipseInRect(context,CGRectMake(centerPoint.x-1, centerPoint.y-1, 2, 2));
	CGContextStrokePath(context);
    
	//For Line
	CGContextSetStrokeColorWithColor(context, currentHandColor.CGColor);
    if(currentHandMode > 0){
        CGContextSetLineWidth(context,4.5);
    }else{
        CGContextSetLineWidth(context,2.5);
    }
	CGPoint fromPoint = [self getPointOfCircleFromAngle:angle andCenterPoint:centerPoint andRadias:2];
	CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
	CGPoint toPoint = [self getPointOfCircleFromAngle:angle andCenterPoint:centerPoint andRadias:radias];
	CGContextAddLineToPoint(context,toPoint.x,toPoint.y);
	CGContextStrokePath(context);
	
	
	
	//degreeAngle += 6;
}

-(CGPoint) getPointOfCircleFromAngle:(double)angle andCenterPoint:(CGPoint)centerPoint andRadias:(double)radias{
	CGPoint returnPoint;
    
	double pointX = centerPoint.x + radias * cos(angle);
	double pointY = centerPoint.y + radias * sin(angle);
	
	returnPoint.x = pointX;
	returnPoint.y = pointY;
    
	//NSLog(@"DegreeAngle:%f  RadianAngle:%f CenterPoint:%f:%f radis:%f answer:%f:%f",degreeAngle,angle,centerPoint.x,centerPoint.y,radias,returnPoint.x,returnPoint.y);
	return returnPoint;
}


@end
