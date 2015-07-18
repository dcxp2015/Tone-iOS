//
//  PlaylistsViewController.m
//  FinalStride
//
//  Created by Rahul Sundararaman on 7/18/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

#import "PlaylistsViewController.h"
#import "SWRevealViewController.h"

@interface PlaylistsViewController ()
//@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@end
@implementation PlaylistsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"Home";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
