//
//  UserCell.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "UserCell.h"
#import "User.h"
#import "UIImageView+WebCache.h"

@interface UserCell () {
}
@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UILabel *urlNameLabel;
@property(nonatomic, retain) IBOutlet UIImageView *pictImageView;

@property(nonatomic, retain) IBOutlet UIButton *twitterButton;
@property(nonatomic, retain) IBOutlet UIButton *profileButton;
@end

@implementation UserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) useUser:(User*)user {
	//TODO:
	self.twitterButton.hidden = YES;
	self.profileButton.hidden = YES;
	
	
	self.user = user;
	
	self.nameLabel.text = user.name;
	self.urlNameLabel.text = user.urlName;
	
	//	NSLog(@"follower: %d", tag.followerCount);
//	self.stockCountLabel.text = [NSString stringWithFormat:@"%d", item.stockCount];
	
	NSURL *url = [NSURL URLWithString:user.profileImageUrl];
	[self.pictImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"man.png"]];
}

-(IBAction) onClickTwitter:(UIButton*)button {
	NSString *url = self.user.twitterUrl;
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(IBAction) onClickProfile:(UIButton*)button {
	NSLog(@"click prof");
	NSDictionary *params = [NSDictionary dictionaryWithObject:self.user forKey:@"user"];
	[[NSNotificationCenter defaultCenter] postNotificationName:EVT_showProfile object:self userInfo:params];
}

@end
