//
//  SoundBitViewController.h
//  Tone
//
//  Created by Danny Flax on 7/14/15.
//  Copyright (c) 2015 Danny Flax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import </usr/include/sqlite3.h>
#import <Parse/Parse.h>
@interface SoundBitViewController : UIViewController <AVAudioRecorderDelegate,AVAudioPlayerDelegate, UIAlertViewDelegate>
{
    UILabel *status;
    NSData *file1Data;
    NSString *filePath;
    NSString *databasePath;
    sqlite3 *contactDB;
}
@property (strong, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *useButton;
- (IBAction)recordPauseTapped:(id)sender;
- (IBAction)stopTapped:(id)sender;
- (IBAction)playTapped:(id)sender;
- (IBAction)useTapped:(id)sender;
@property (nonatomic, retain) NSString *rowlen;

@end
