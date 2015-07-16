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
#import </usr/include/sqlite3.h>

@interface SoundBitViewController ()

@end

@implementation SoundBitViewController
AVAudioRecorder *recorder;
AVAudioPlayer *player;

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
    // Do any additional setup after loading the view, typically from a nib.
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"myfiles.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS MYFILES(ID INTEGER PRIMARY KEY AUTOINCREMENT, AUDIOFILE BLOB)";
            
            if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
               NSLog(@"Failed to create table");
            }
            
            sqlite3_close(contactDB);
            
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
    
   // [filemgr release];
    
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
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Name" message:@"What do you want this to be called?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
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
        NSString *mp3FileName = @"/var/MyFileName.mp3";
        //NSLog(mp3FileName);
        NSLog(@"%@", NSDocumentDirectory);
        [[NSFileManager defaultManager] createFileAtPath:mp3FileName
                                                contents:file1Data
                                              attributes:nil];
        file1Data = [[NSData alloc] initWithContentsOfFile:[recorder.url absoluteString]];
        
        NSString *FileNamePath = @"MyFileName.mp3";
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *appSettingsPath = [documentsDirectory stringByAppendingPathComponent:FileNamePath];
        NSURL *url=[[NSURL alloc]initWithString:appSettingsPath ];
        player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
        player.delegate=self;
        [player play];
        NSLog(@"asdfsa");
        
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
@end
