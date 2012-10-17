//
//  Item.h
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *body;
@property(nonatomic, assign) int stockCount;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSArray *tags;

//createdAt,updatedAt
//user
//tags
//stockUsers
//commentCount


-(id) initWithDictionary:(NSDictionary*)dictionary;

@end
