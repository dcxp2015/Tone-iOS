//
//  PlaylistDetailViewController.m
//  Tone
//
//  Created by Danny Flax on 7/14/15.
//  Copyright (c) 2015 Danny Flax. All rights reserved.
//

#import "PlaylistDetailViewController.h"
#import "SoundBitViewController.h"

@interface PlaylistDetailViewController ()

@end

@implementation PlaylistDetailViewController
@synthesize selectedRow;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(refreshPropertyList:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    //[anotherButton release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)refreshPropertyList:(id)sender{
    SoundBitViewController *_view = [self.storyboard instantiateViewControllerWithIdentifier:@"soundBit"];
   // _view.selectedRow = [tableData objectAtIndex: indexPath.row];
    [self.navigationController pushViewController:_view animated:YES];
    NSLog(@"asdfas");
}
@end
