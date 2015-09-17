//
//  RunningViewController.h
//  FinalStride
//
//  Created by Rahul Sundararaman on 7/21/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
double currentMaxAccelX;
double currentMaxAccelY;
double currentMaxAccelZ;
double currentMaxRotX;
double currentMaxRotY;
double currentMaxRotZ;
@interface RunningViewController : UIViewController
-(void)timerTick:(NSTimer *)timer;

@property (strong, nonatomic) CMMotionManager *motionManager;
@end
