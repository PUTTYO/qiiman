//
//  ItemCell.h
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;
@interface ItemCell : UITableViewCell

-(void) useItem:(Item*)item;

@end
