//
//  FirstViewController.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/09.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "TagListVC.h"
#import "UserListVC.h"
#import "Tag.h"
#import "TagCell.h"
#import "QiitaAPIClient.h"
#import "Util.h"

@interface TagListVC ()
// model
@property(nonatomic, strong) NSMutableArray *tags;
// view
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation TagListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"言語/技術";
		self.tabBarItem.image = [UIImage imageNamed:@"first"];
		
		self.tags = [[NSMutableArray alloc] init];
		
		self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowUserList:) name:EVT_showUserList object:nil];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	CGRect screenBounds = [UIScreen mainScreen].bounds;
	self.tableView.frame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height);
	[self.view addSubview:self.tableView];
	
	NSDictionary *params = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:100] forKey:@"per_page"];
	
	[APP_DELEGATE beginHud];
	[[QiitaAPIClient sharedClient] getPath:@"tags" parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
		[APP_DELEGATE endHud];
		
		NSLog(@"success: %d", [JSON count]);
        for (NSDictionary *attributes in JSON) {
			Tag *tag = [[Tag alloc] initWithDictionary:attributes];
			[self.tags addObject:tag];
		}
		[self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[APP_DELEGATE endHud];
		
		[Util showAlert:@"接続がタイムアウトしました。"];

		NSLog(@"fail!");
    }];
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
	return [self.tags count];
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellId = @"TagCell";
	
	TagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil) {
//		UITableViewCellStyle style = UITableViewCellStyleDefault;
//		cell = [[TagCell alloc] initWithStyle:style reuseIdentifier:cellId];
		
		UINib *nib = [UINib nibWithNibName:@"TagCell" bundle:nil];
		NSArray *array = [nib instantiateWithOwner:nil options:nil];
		cell = [array objectAtIndex:0];
	}
	
	[cell useTag:[self.tags objectAtIndex:indexPath.row]];
	
	return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Tag *tag = [self.tags objectAtIndex:indexPath.row];
	
	NSDictionary *params = [NSDictionary dictionaryWithObject:tag forKey:@"tag"];
	[[NSNotificationCenter defaultCenter] postNotificationName:EVT_showUserList object:self userInfo:params];
}

- (void) onShowUserList:(NSNotification*)ntf {
	Tag *tag = [ntf.userInfo objectForKey:@"tag"];
	
	UserListVC *userListVC = [[UserListVC alloc] init];
	[self.navigationController pushViewController:userListVC animated:YES];
	[userListVC useTag:tag];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2 == 1) {
		cell.backgroundColor = [UIColor colorWithRed:0.95 green:1.0 blue:0.95 alpha:1.0];
	} else {
		cell.backgroundColor = [UIColor whiteColor];
	}
}

@end
