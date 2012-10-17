//
//  Tag.h
//  qiita
//
//  Created by 池田 優一 on 2012/10/10.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tag : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *urlName;
@property(nonatomic, assign) int itemCount;
@property(nonatomic, assign) int followerCount;
@property(nonatomic, strong) NSString *iconUrl;

-(id) initWithDictionary:(NSDictionary*)dictionary;

@end
