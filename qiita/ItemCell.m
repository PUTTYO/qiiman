//
//  ItemCell.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "LKBadgeView.h"
#import "ItemCell.h"
#import "Item.h"

@interface ItemCell () {
}
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;
@property(nonatomic, strong) IBOutlet UILabel *tagLabel;
@property(nonatomic, strong) IBOutlet LKBadgeView *stockCountLabel;
@end

@implementation ItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		float badgeW = 40, badgeH = 40;
		float pad = 5;

        // Initialization code
		self.stockCountLabel = [[LKBadgeView alloc] initWithFrame:CGRectMake(self.frame.size.width - pad*2 - badgeW*2, pad, badgeW, badgeH)];
		[self addSubview:self.stockCountLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) useItem:(Item*)item {
//	self.textLabel.text = item.title;
	self.titleLabel.text = item.title;
//	self.tagLabel.text =
	//TODO: tags
	self.tagLabel.text = [item.tags componentsJoinedByString:@" "];
	
	//	NSLog(@"follower: %d", tag.followerCount);
	self.stockCountLabel.text = [NSString stringWithFormat:@"%d", item.stockCount];
	
}

@end
