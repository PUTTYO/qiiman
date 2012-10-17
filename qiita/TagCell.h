//
//  TagCell.h
//  qiita
//
//  Created by 池田 優一 on 2012/10/10.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tag;

@interface TagCell : UITableViewCell

-(void) useTag:(Tag*)tag;

@end
