//
//  ViewController.m
//  Tone
//
//  Created by Danny Flax on 7/14/15.
//  Copyright (c) 2015 Danny Flax. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    NSLog(@"Achieved");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
