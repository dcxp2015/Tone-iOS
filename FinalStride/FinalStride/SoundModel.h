//
//  SoundModel.h
//  FinalStride
//
//  Created by Rahul Sundararaman on 7/19/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

#import "JSONModel.h"

@interface SoundModel : JSONModel
@property (strong, nonatomic) NSString* id;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* artist;
@end
@protocol SoundModel
@end
