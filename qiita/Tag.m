//
//  Tag.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/10.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "Tag.h"

@implementation Tag

-(id) initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {
		self.name = [dictionary objectForKey:@"name"];
		self.urlName = [dictionary objectForKey:@"url_name"];
		self.followerCount = [[dictionary objectForKey:@"follower_count"] intValue];
		self.itemCount = [[dictionary objectForKey:@"item_count"] intValue];
		self.iconUrl = [dictionary objectForKey:@"icon_url"];
	}
	return self;
}
@end
