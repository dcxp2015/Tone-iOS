//
//  PlaylistsViewController.m
//  FinalStride
//
//  Created by Rahul Sundararaman on 7/18/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

#import "PlaylistsViewController.h"
#import "SWRevealViewController.h"
#import "PlaylistModel.h"
#import <Parse/Parse.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface PlaylistsViewController ()<UITableViewDataSource, UITableViewDelegate>
//@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//@synthesize tableView
@end
@implementation PlaylistsViewController
NSMutableArray *tableData;
- (void)viewDidLoad
{
    //PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //testObject[@"foo"] = @"bar";
    
    //[testObject saveInBackground];
    NSMutableArray *songids = [NSMutableArray arrayWithObjects:@"", nil];
    NSMutableDictionary *playlists=[[NSMutableDictionary alloc] init];
    //[playlists setObject:@"" forKey:@"playlistname"];
    //[playlists setObject:songids forKey:@"songarray"];
    NSLog(@"%@", playlists);
   // NSLog(@"->%@",playlists);
    NSData *data = [NSJSONSerialization dataWithJSONObject:playlists
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: data forKey:@"data"];
    [defaults synchronize];
    //NSLog(myjson);
    //NSLog(@"Up here");
    PFQuery *query = [PFQuery queryWithClassName:@"Phrases"];
    [query selectKeys:@[@"objectId"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        NSLog(@"up here");
       // __block NSMutableDictionary *dict = [NSMutableDictionary new];
        // Array of ratings objectIds to fetch
        //NSMutableArray *ratingsToFetch = [NSMutableArray new];
        int c1 = 0;
        for (PFObject *object in users) {
            c1++;
            //NSLog(@"%@", object.objectId);
            [songids addObject:object.objectId];
            
            if(c1==10){
                [playlists setObject:@"Shia Labeouf"  forKey:@"playlistname1"];
                [playlists setObject:songids  forKey:@"songarray1"];
               // NSLog(@"%@", songids);
               // NSLog(@"at 10");
                [songids removeAllObjects];
                 //NSLog(@"%@", playlists);
            }
            else if(c1 == 20){
                [playlists setObject:@"Workout" forKey:@"playlistname2"];
                [playlists setObject:songids forKey: @"songarray2"];
                
                //NSLog(@"at 20");
                //NSLog(@"%@", songids);
                
            }
            else if(c1 == [users count]){
                NSLog(@"%@", playlists);
                for(int x = 0; x<[playlists count]/2; x++){
                    NSLog(@"dfjsa");
                }
                tableData = [NSMutableArray arrayWithObjects:playlists[@"playlistname1"], playlists[@"playlistname2"], nil];
                [self.tableView reloadData];
            }
           // NSLog(object[@"Title"]);
        }
        PFQuery *query = [PFQuery queryWithClassName:@"Phrases"];
        [query selectKeys:@[@"Audio"]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            // iterate through the objects array, which contains PFObjects for each Student
            for(int k = 0; k<[objects count]; k++){
                //NSData *urlData = objects[k][@"Audio"];
                [objects[k][@"Audio"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                       // NSLog(@"bytes in hex: %@", [data description]);
                        // image can now be set on a UIImageView
                        
                    }
                }];                //NSString *soundFilePath = [NSString stringWithFormat:@"%@/filename.mp3",
                //                           [[NSBundle mainBundle] resourcePath]];
                //NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
                //AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                //                                                               error:nil];
                //player.numberOfLoops = -1; //Infinite
                
                //[player play];
            }
        }];
       // NSLog([NSString stringWithFormat:@"%lu", (unsigned long)[users count]]);
       // NSLog(@"%@",songids);
        //NSDictionary *myjson = [defaults objectForKey:@"data"];
        //NSString *jsonStr = [[NSString alloc] initWithData:myjson
        //                                          encoding:NSUTF8StringEncoding];
        //NSLog(@"%@", jsonStr);
        //NSLog(@"%@", myjson);

    }];
    //NSLog(jsonStr);
   // NSLog(@"got down here");
    //NSData *data = [NSJSONSerialization dataWithJSONObject:playlists
    //                                               options:NSJSONWritingPrettyPrinted
    //                                                 error:nil];
    //NSString *jsonStr = [[NSString alloc] initWithData:data
    //                                          encoding:NSUTF8StringEncoding];
    //NSLog(jsonStr);
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject:jsonStr forKey:@"data"];
    //[defaults synchronize];

    [super viewDidLoad];
    //self.title = @"Home";
    
    //[self.view addSubview: self.label];
    
    //[self fetchJokes];
    
    //NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDetails
      //                                                 options:kNilOptions
        //                                                 error:&error];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"Got down here");
    NSLog([NSString stringWithFormat:@"%lu", (unsigned long)[tableData count]]);
    return [tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
