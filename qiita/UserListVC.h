//
//  UserListVC.h
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tag;

@interface UserListVC : UIViewController
<UITableViewDelegate, UITableViewDataSource>

//-(void) refresh;

-(void) useTag:(Tag*)tag;

@end
