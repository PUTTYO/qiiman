//
//  Item.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "Item.h"
#import "Tag.h"

@implementation Item

-(id) initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {
		self.title = [dictionary objectForKey:@"title"];
		self.body = [dictionary objectForKey:@"body"];
		NSLog(@"%@", self.body);
		self.url = [dictionary objectForKey:@"url"];
		self.stockCount = [[dictionary objectForKey:@"stock_count"] intValue];
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		for (NSDictionary *attribute in [dictionary objectForKey:@"tags"]) {
			Tag *tag = [[Tag alloc] initWithDictionary:attribute];
			//TODO:
			[array addObject:tag.name];
		}
		self.tags = array;
	}
	return self;
}

@end
