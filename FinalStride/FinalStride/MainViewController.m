//
//  MainViewController.m
//  FinalStride
//
//  Created by Rahul Sundararaman on 7/18/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
@interface MainViewController ()
//@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@end
@implementation MainViewController
NSArray *pickerData;
- (void)viewDidLoad
{
    /*NSMutableDictionary *songs = [[NSMutableDictionary alloc] init];
    [songs setObject:@"0" forKey:@"id"];
    [songs setObject:@" " forKey:@"songname"];
    [songs setObject:@" " forKey:@"artist"];
    
    NSMutableDictionary *playlists = [[NSMutableDictionary alloc] init];
    [playlists setObject:@"0" forKey:@"id"];
    [playlists setObject: @" " forKey:@"playlistname"];
    [playlists setObject: songs forKey:@"song"];*/
    //PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //testObject[@"foo"] = @"bar";
    //[testObject saveInBackground];
    //NSDictionary *songs = @{@"songname":@" ", @"artist":@" ", @"pathtofile":@" "};
    

   // NSLog(jsonStr);
   // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject:jsonStr forKey:@"data"];
    //[defaults synchronize];
    [super viewDidLoad];
    //self.title = @"Home";
    pickerData = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Item 6"];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
