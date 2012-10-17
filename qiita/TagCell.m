//
//  TagCell.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/10.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "TagCell.h"
#import "Tag.h"
#import "LKBadgeView.h"
#import "UIImageView+WebCache.h"

@interface TagCell () {
}
@property(nonatomic, strong) IBOutlet UIImageView *pictImageView;
@property(nonatomic, strong) IBOutlet UILabel *nameLabel;

//TODO: badge to IB
@property(nonatomic, strong) IBOutlet LKBadgeView *followerCountLabel;
@property(nonatomic, strong) IBOutlet LKBadgeView *itemCountLabel;
@end


@implementation TagCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) useTag:(Tag *)tag {
	self.nameLabel.text = tag.name;
	
	//R:0 G:255 B:127
	UIColor *green = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:87/255.0 alpha:1.0];
	self.followerCountLabel.badgeColor = green;
    self.followerCountLabel.text = [NSString stringWithFormat:@"%d", tag.followerCount];
	self.itemCountLabel.text = [NSString stringWithFormat:@"%d", tag.itemCount];
	self.itemCountLabel.badgeColor = green;

	NSURL *url = [NSURL URLWithString:tag.iconUrl];
	[self.pictImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"man.png"]];
	
//	float badgeW = 40, badgeH = 40;
//	float pad = 5;
//	
//	self.followerCountLabel = [[LKBadgeView alloc] initWithFrame:CGRectMake(self.frame.size.width - pad - badgeW, pad, badgeW, badgeH)];
//	[self addSubview:self.followerCountLabel];
//	
//	self.itemCountLabel = [[LKBadgeView alloc] initWithFrame:CGRectMake(self.frame.size.width - pad*2 - badgeW*2, pad, badgeW, badgeH)];
//	[self addSubview:self.itemCountLabel];
}

@end
