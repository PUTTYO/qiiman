//
//  AppDelegate.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/09.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "AppDelegate.h"
#import "TagListVC.h"
#import "ItemListVC.h"
#import "UserListVC.h"
#import "ProfileVC.h"
#import "ATMHud.h"

@interface AppDelegate () {
	ATMHud *_hud;
	int _hudCount;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//	UserListVC *userListVC = [[UserListVC alloc] init];
//	UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:userListVC];
//	[userListVC useTag:nil];
	
	TagListVC *tagListVC = [[TagListVC alloc] init];
	UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:tagListVC];
	self.window.rootViewController = navC;

//	ProfileVC *profileVC = [[ProfileVC alloc] init];
//	self.window.rootViewController = profileVC;
//	[profileVC useUser:nil];
	
	_hud = [[ATMHud alloc] initWithDelegate:self];
	_hudCount = 0;
	[self.window addSubview:_hud.view];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Optional UITabBarControllerDelegate method.
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//	if ([viewController class] == [TagListVC class]) {
//		NSLog(@"tag list");
//	}
//	else if ([viewController class] == [ItemListVC class]) {
//		NSLog(@"item list");
//	}
//	else if ([viewController class] == [UserListVC class]) {
//		NSLog(@"user list");
//		UserListVC *userVC = (UserListVC*)viewController;
//		[userVC refresh];
//	}
//}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

#pragma mark - hud

- (void) beginHud
{
	if (_hudCount <= 0) {
		[self.window bringSubviewToFront:_hud.view];
//		[_hud setCaption:NSLocalizedString(@"通信中",nil)];
		[_hud setActivity:YES];
		[_hud show];
		
		//NOTE: メインループで処理の重い処理をする場合、描画がストップしてしまうのを回避
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.05]];
	}
	
	_hudCount ++;
}

- (void) endHud
{
	if (_hudCount <= 1) {
		[_hud hide];
	}
	
	_hudCount --;
	
	//NOTE: 念のため負数抑制
	if (_hudCount < 0) {
		_hudCount = 0;
	}
}



@end
