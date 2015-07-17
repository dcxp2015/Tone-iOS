//
//  SoundBitViewController.m
//  Tone
//
//  Created by Danny Flax on 7/14/15.
//  Copyright (c) 2015 Danny Flax. All rights reserved.
//

#import "SoundBitViewController.h"
#import <AVFoundation/AVFoundation.h>
//#import <CoreData/CoreDataAppDelegate.h>
#import <CoreData/CoreData.h>
//#import </usr/include/sqlite3.h>
#import "DBManager.h"
#import "Variables.h"
#import <Parse/Parse.h>
@interface SoundBitViewController ()

@end

@implementation SoundBitViewController
AVAudioRecorder *recorder;
AVAudioPlayer *player;
UITextField *textfield;
UIAlertView *alert;
extern int superGlobal;
@synthesize rowlen = _rowlen;
NSUserDefaults *defaults;
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [alert textFieldAtIndex:0];
    // Do any additional setup after loading the view, typically from a nib.
    
   // [filemgr release];
    defaults = [NSUserDefaults standardUserDefaults];
    
    [_stopButton setEnabled:NO];
    [_playButton setEnabled:NO];
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    //Variables.rowlength = 1;
    superGlobal++;
    NSLog(@"soundbit");
    NSLog([NSString stringWithFormat:@"%i", superGlobal]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordPauseTapped:(id)sender {
    if (player.playing) {
        [player stop];
    }
    
    if (!recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        [_recordPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    } else {
        
        // Pause recording
        [recorder pause];
        [_recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    
    [_stopButton setEnabled:YES];
    [_playButton setEnabled:NO];
    
}

- (IBAction)stopTapped:(id)sender {
    [recorder stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (IBAction)playTapped:(id)sender {
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player play];
    }
}

- (IBAction)useTapped:(id)sender {
     alert = [[UIAlertView alloc] initWithTitle:@"Name" message:@"What do you want this to be called?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    //textfield =  [alert textFieldAtIndex: 0];
    [alert show];

}
- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [_recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    
    [_stopButton setEnabled:NO];
    [_playButton setEnabled:YES];
}
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
       
    }else{
        
        //NSString *mp3FileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                //                      NSUserDomainMask,
                                                //                      YES) lastObject]
                                 //stringByAppendingPathComponent:@"/sadfas/MyFileName.mp3"];
        file1Data = [[NSData alloc] initWithContentsOfFile:[recorder.url absoluteString]];
        NSString *mp3FileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                      NSUserDomainMask,
                                                                      YES) lastObject]
                                 stringByAppendingPathComponent:@"MyFileName.mp3"];
        [[NSFileManager defaultManager] createFileAtPath:mp3FileName
                                                contents:file1Data
                                              attributes:nil];
        
        
        mp3FileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                      NSUserDomainMask,
                                                                      YES) lastObject]
                                 stringByAppendingPathComponent:@"MyFileName.mp3"];
       // NSData *mp3Data = [NSData dataWithContentsOfFile:mp3FileName];
        [defaults setObject:[alertView textFieldAtIndex: 0].text forKey:@"hello"];
       // NSLog(self.rowlen);
       // NSLog([alertView textFieldAtIndex: 0].text);
        [defaults synchronize];
         NSString *vall = [defaults stringForKey:@"hello"];
        //NSLog(@"got down here");
        NSLog(vall);
        
        /*NSManagedObjectContext *context = [self managedObjectContext];
        
        // Create a new managed object
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Filestore" inManagedObjectContext:context];
        [newDevice setValue:file1Data forKey:@"soundbit"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }*/
        //CoreDataAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(_rowlen);
}
@end
