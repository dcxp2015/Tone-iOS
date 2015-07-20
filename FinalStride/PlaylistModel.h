//
//  PlaylistModel.h
//  FinalStride
//
//  Created by Rahul Sundararaman on 7/19/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "SoundModel.h"
@interface PlaylistModel : JSONModel
@property (strong, nonatomic) NSString* id;
@property (assign, nonatomic) NSString *pname;
//@property (strong, nonatomic) NSString *songs;
@property (strong, nonatomic) NSArray<SoundModel, Optional>* songs;
@end