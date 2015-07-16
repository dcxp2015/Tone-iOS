//
//  PlaylistDetailViewController.m
//  Tone
//
//  Created by Danny Flax on 7/14/15.
//  Copyright (c) 2015 Danny Flax. All rights reserved.
//

#import "PlaylistDetailViewController.h"

@interface PlaylistDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lbl;

@end

@implementation PlaylistDetailViewController
@synthesize selectedRow;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _lbl.text = selectedRow;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
