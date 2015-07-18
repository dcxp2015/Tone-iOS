//
//  DBManager.h
//  Tone
//
//  Created by Rahul Sundararaman on 7/17/15.
//  Copyright (c) 2015 Danny Flax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData:(NSString*)registerNumber filepath:(NSString*)filepath;
-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;

@end