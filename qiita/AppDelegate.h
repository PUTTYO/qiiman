//
//  AppDelegate.h
//  qiita
//
//  Created by 池田 優一 on 2012/10/09.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

-(void) beginHud;
-(void) endHud;

@end
