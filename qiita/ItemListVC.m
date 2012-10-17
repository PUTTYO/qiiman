//
//  SecondViewController.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/09.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "QiitaAPIClient.h"
#import "Item.h"
#import "ItemCell.h"
#import "ItemListVC.h"
#import "User.h"
#import "const.h"

@interface ItemListVC ()
// model
@property(nonatomic, strong) NSMutableArray *items;
// view
@property(nonatomic, retain) UITableView *tableView;
@end

@implementation ItemListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = @"記事一覧";
		self.tabBarItem.image = [UIImage imageNamed:@"second"];
		
		self.items = [[NSMutableArray alloc] init];

		self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];

	CGRect screenBounds = [UIScreen mainScreen].bounds;
	self.tableView.frame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height);
	[self.view addSubview:self.tableView];
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
	return [self.items count];
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellId = @"ItemCell";
	
	ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil) {
//		UITableViewCellStyle style = UITableViewCellStyleDefault;
//		cell = [[ItemCell alloc] initWithStyle:style reuseIdentifier:cellId];
		
		UINib *nib = [UINib nibWithNibName:@"ItemCell" bundle:nil];
		NSArray *array = [nib instantiateWithOwner:nil options:nil];
		cell = [array objectAtIndex:0];
	}
	
	[cell useItem:[self.items objectAtIndex:indexPath.row]];
	
	return cell;
}

-(void) useUser:(User *)user {
//	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//							[NSNumber numberWithInt:100], @"per_page",
//							@"iOS", @"q", nil];
	NSDictionary *params = nil;
	NSString *path = [NSString stringWithFormat:@"users/%@/items", user.urlName];
	
	[APP_DELEGATE beginHud];
	//	[[QiitaAPIClient sharedClient] getPath:@"search" parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
	[[QiitaAPIClient sharedClient] getPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
		[APP_DELEGATE endHud];
		
		NSLog(@"success: %d", [JSON count]);
        for (NSDictionary *attributes in JSON) {
			NSLog(@"%@", attributes);
			Item *item = [[Item alloc] initWithDictionary:attributes];
			[self.items addObject:item];
		}
		[self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[APP_DELEGATE endHud];
		
		//TODO: alert
		NSLog(@"fail!");
    }];
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2 == 1) {
		cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:1.0 alpha:1.0];
	} else {
		cell.backgroundColor = [UIColor whiteColor];
	}
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Item *item = [self.items objectAtIndex:indexPath.row];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.url]];
}

@end
