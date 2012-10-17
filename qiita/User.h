//
//  User.h
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *urlName;
@property(nonatomic, strong) NSString *profileImageUrl;

// detail
@property(nonatomic, strong) NSString *description;
@property(nonatomic, assign) int followerCount;
@property(nonatomic, assign) int followingCount;
@property(nonatomic, assign) int itemCount;
@property(nonatomic, strong) NSString *twitter;
@property(nonatomic, strong) NSString *github;

-(id) initWithDictionary:(NSDictionary*)dictionary;

-(NSString*) twitterUrl;
-(NSString*) githubUrl;

@end
