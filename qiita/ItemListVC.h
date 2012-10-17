//
//  SecondViewController.h
//  qiita
//
//  Created by 池田 優一 on 2012/10/09.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface ItemListVC : UIViewController
<UITableViewDelegate, UITableViewDataSource>

-(void) useUser:(User*)user;

@end
