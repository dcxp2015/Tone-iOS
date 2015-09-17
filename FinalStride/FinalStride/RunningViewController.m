//
//  RunningViewController.m
//  FinalStride
//
//  Created by Rahul Sundararaman on 7/21/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

#import "RunningViewController.h"
#import <CoreMotion/CoreMotion.h>
#define kCMDeviceMotionUpdateFrequency (0.01f)
@interface RunningViewController ()

@end

@implementation RunningViewController
int count = 0;
float timed = 0.0f;
NSTimer *timer;
NSString *accvector = @"";
NSString *final = @"";
NSString *prev = @"";

-(CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = kCMDeviceMotionUpdateFrequency;
    }
    
    return _motionManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    CMAcceleration acceleration = self.motionManager.deviceMotion.userAcceleration;
    NSString *a =@", ";
    NSString *x = [a stringByAppendingString:[NSString stringWithFormat:@"%.3f", (acceleration.x*9.81)]];
    NSString *b =@", ";
    NSString *y = [b stringByAppendingString:[NSString stringWithFormat:@"%.3f", (acceleration.y*9.81)]];
    NSString *c =@", ";
    NSString *z = [c stringByAppendingString:[NSString stringWithFormat:@"%.3f", (acceleration.z*9.81)]];
    NSString *d =@" \n";
    accvector = [accvector stringByAppendingString: [[[x stringByAppendingString:y]stringByAppendingString:z]stringByAppendingString:d]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
