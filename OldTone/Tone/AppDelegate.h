//
//  AppDelegate.h
//  Tone
//
//  Created by Danny Flax on 7/14/15.
//  Copyright (c) 2015 Danny Flax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

