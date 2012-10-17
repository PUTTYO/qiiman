//
//  UserListVC.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "QiitaAPIClient.h"
#import "UserListVC.h"
#import "User.h"
#import "UserCell.h"
#import "ProfileVC.h"
#import "Tag.h"
#import "Util.h"

@interface UserListVC ()
// model
@property(nonatomic, strong) NSMutableArray *users;
// view
@property(nonatomic, retain) UITableView *tableView;
@end

@implementation UserListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.users = [[NSMutableArray alloc] init];
		
		self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowProfile:) name:EVT_showProfile object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	CGRect screenBounds = [UIScreen mainScreen].bounds;
	self.tableView.frame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height);
	[self.view addSubview:self.tableView];
	
//	[self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.users count];
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellId = @"UserCell";
	
	UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil) {
		UINib *nib = [UINib nibWithNibName:@"UserCell" bundle:nil];
		NSArray *array = [nib instantiateWithOwner:nil options:nil];
		cell = [array objectAtIndex:0];
	}
	[cell useUser:[self.users objectAtIndex:indexPath.row]];
	
	return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0;
}

- (void) useTag:(Tag*)tag {
	// タイトル変更
	self.title = [NSString stringWithFormat:@"%@ のプロたち", tag.name];
	
	[self.users removeAllObjects];
	
//	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//							[NSNumber numberWithInt:10], @"per_page",
//							tag.name, @"q", nil];
//	NSString *path = @"search";
	NSDictionary *params = nil;
	NSString *urlName;
	if (tag == nil) {
		urlName = @"ruby";
	} else {
		urlName = tag.urlName;
	}
	NSString *path = [NSString stringWithFormat:@"tags/%@/items", urlName];
	
	[APP_DELEGATE beginHud];
	[[QiitaAPIClient sharedClient] getPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
		[APP_DELEGATE endHud];
		
		NSLog(@"success: %d", [JSON count]);
        for (NSDictionary *attributes in JSON) {
			NSLog(@"%@", attributes);
			NSDictionary *userDic = [attributes objectForKey:@"user"];
			User *user = [[User alloc] initWithDictionary:userDic];
			[self.users addObject:user];
		}
		[self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[APP_DELEGATE endHud];
		
		[Util showAlert:@"接続がタイムアウトしました。"];

		NSLog(@"fail!: %@", error.localizedDescription);
    }];
}

- (void) onShowProfile:(NSNotification*)ntf {
	User *user = [ntf.userInfo objectForKey:@"user"];
	
	NSLog(@"user: %@", user.name);
	
	ProfileVC *profileVC = [[ProfileVC alloc] init];
	[self.navigationController pushViewController:profileVC animated:YES];
	[profileVC useUser:user];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	User *user = [self.users objectAtIndex:indexPath.row];
	
	ProfileVC *profileVC = [[ProfileVC alloc] init];
	[self.navigationController pushViewController:profileVC animated:YES];
	[profileVC useUser:user];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2 == 1) {
		cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:1.0 alpha:1.0];
	} else {
		cell.backgroundColor = [UIColor whiteColor];
	}
}

@end
