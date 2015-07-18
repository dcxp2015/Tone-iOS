//
//  PlaylistDetailViewController.m
//  Tone
//
//  Created by Danny Flax on 7/14/15.
//  Copyright (c) 2015 Danny Flax. All rights reserved.
//

#import "PlaylistDetailViewController.h"
#import "DBManager.h"
#import "SoundBitViewController.h"
#import "Variables.h"
#import <Parse/Parse.h>
@interface PlaylistDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) IBOutlet UITableView *tView;

@end

@implementation PlaylistDetailViewController
NSMutableArray *tData;
UITextField *inputField;
NSIndexPath *indexpath = 0;
NSString *tempp = @"";
NSUserDefaults *defaul;
extern int superGlobal;
@synthesize selectedRow;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)
//nibBundleOrNil
//{
  //  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //if (self) {
        // Custom initialization
    //}
    //return self;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
     defaul = [NSUserDefaults standardUserDefaults];
    superGlobal++;
    NSLog(@"playlist detail");
    NSLog([NSString stringWithFormat:@"%i", superGlobal]);
    // Initialize table data
    self.tView.allowsMultipleSelectionDuringEditing = NO;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tView addGestureRecognizer:longPress];
    //[self.tView setEditing:YES animated:YES];
   // NSLog(@"asdfdsafsafdsafs");
    tData = [NSMutableArray arrayWithObjects: @"Playlist 1", @"Playlist 2", nil];
    NSInteger numberOfItems = 30;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int counter =0;
    while([defaults stringForKey:[NSString stringWithFormat:@"%li", (long)counter]]){
        NSString *vall = [defaults stringForKey:[NSString stringWithFormat:@"%li", (long)counter]];
        [tData addObject: vall];
        counter++;
    }
    NSLog([NSString stringWithFormat:@"%lu",(unsigned long)[tData count]]);
    tempp = [NSString stringWithFormat:@"%lu",(unsigned long)[tData count]];
    //NSInteger theHighScore = [defaults integerForKey:];
   // for(NSInteger i=1; i<numberOfItems; i++){
    //    NSString *item = [NSString stringWithFormat:@"Item #%d", i];
     //   [tData addObject: item];
    //}
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    btn.frame = CGRectMake(screenWidth-10, 5, 30, 30);
    [btn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(resetCriteria:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(refreshPropertyList:)];
    anotherButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //UIImage *bImage = [UIImage imageNamed:@"add.png"];
   // [self.tView registerClass: [UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    //[anotherButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = anotherButton;
    //self.tView.allowsMultipleSelectionDuringEditing = NO;
}
- (NSInteger)tableView:(UITableView *)tView numberOfRowsInSection:(NSInteger)section
{
    return [tData count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tData objectAtIndex:indexPath.row];

    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    // set the frame and title you want
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [b setFrame:CGRectMake(screenWidth/1.2, 5, 35, 35)];
    [b setTitle:@"" forState:UIControlStateNormal];
    // set action/target you want
    [b addTarget:self
          action:@selector(playSong:)
forControlEvents:UIControlEventTouchUpInside];
    UIImage *buttonImage = [UIImage imageNamed:@"play.png"];
    [b setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [cell addSubview:b];
    indexpath =  indexPath;
    return cell;
}

- (IBAction)playSong:(id)sender {
    
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
 //   int rowNo = indexPath.row;
    
//}
- (IBAction)resetCriteria:(id)sender {
    SoundBitViewController *_view = [self.storyboard instantiateViewControllerWithIdentifier:@"soundBit"];
    // _view.selectedRow = [tableData objectAtIndex: indexPath.row];
    [self.navigationController pushViewController:_view animated:YES];
    NSLog(@"asdfas");
}

- (IBAction)longPressGestureRecognized:(id)sender {
    
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tView];
    NSIndexPath *indexPath = [self.tView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self.tView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshotFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [tData exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [self.tView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            
            break;
        }
    }
}
- (UIView *)customSnapshotFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)refreshPropertyList:(id)sender{
    SoundBitViewController *_view = [self.storyboard instantiateViewControllerWithIdentifier:@"soundBit"];
    // _view.selectedRow = [tableData objectAtIndex: indexPath.row];
    NSLog(@"Got down HERE");
    _view.rowlen=tempp;
    [self.navigationController pushViewController:_view animated:YES];
    NSLog(@"asdfas");
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *vall = [defaul stringForKey:@"hello"];
    NSLog(@"Here");
    NSLog(vall);
    [super viewWillAppear:animated];
   // NSLog(@"view will Appear");
}
@end

