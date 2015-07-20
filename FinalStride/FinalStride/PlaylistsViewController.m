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
@interface PlaylistsViewController ()<UITableViewDataSource, UITableViewDelegate>
//@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
@implementation PlaylistsViewController
NSMutableArray *tableData;
- (void)viewDidLoad
{
    NSLog(@"Up here");
    [super viewDidLoad];
    //self.title = @"Home";
    tableData = [NSMutableArray arrayWithObjects:@"Playlist 1", @"Playlist 2", nil];
    
    //[self.view addSubview: self.label];
    
    [self fetchJokes];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}
- (void)fetchJokes {
    NSURL* jokesUrl = [NSURL URLWithString:@"https://s3.amazonaws.com/com.tuts.mobile/playlists.json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:jokesUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        tableData = [PlaylistModel arrayOfModelsFromData:data error:nil];
    }] resume];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Got down here");
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
