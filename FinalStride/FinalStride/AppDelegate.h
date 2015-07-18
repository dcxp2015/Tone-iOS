//
//  AppDelegate.h
//  FinalStride
//
//  Created by Rahul Sundararaman on 7/17/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
//I was here

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

