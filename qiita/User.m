//
//  User.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "User.h"

@implementation User

-(id) initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {
		self.name = [dictionary objectForKey:@"name"];
		self.urlName = [dictionary objectForKey:@"url_name"];
		self.profileImageUrl = [dictionary objectForKey:@"profile_image_url"];
		
		self.description = [dictionary objectForKey:@"description"];
		self.followingCount = [[dictionary objectForKey:@"following_users"] intValue];
		self.followerCount = [[dictionary objectForKey:@"followers"] intValue];
		self.itemCount = [[dictionary objectForKey:@"items"] intValue];
		self.twitter = [dictionary objectForKey:@"twitter"];
		self.github = [dictionary objectForKey:@"github"];
		
		NSLog(@"desc: %@", self.description);
	}
	return self;
}

-(NSString*) twitterUrl {
	return [NSString stringWithFormat:@"http://twitter.com/%@", self.twitter];
}

-(NSString*) githubUrl {
	return [NSString stringWithFormat:@"http://github.com/%@", self.github];
}

@end
