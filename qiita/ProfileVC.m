//
//  ProfileVC.m
//  qiita
//
//  Created by 池田 優一 on 2012/10/13.
//  Copyright (c) 2012年 池田 優一. All rights reserved.
//

#import "ProfileVC.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "QiitaAPIClient.h"
#import "Util.h"
#import "ItemListVC.h"

@interface ProfileVC ()
@property(nonatomic, strong) IBOutlet UIImageView *pictImageView;
@property(nonatomic, strong) IBOutlet UILabel *nameLabel;
@property(nonatomic, strong) IBOutlet UILabel *urlNameLabel;
@property(nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property(nonatomic, strong) IBOutlet UIButton *followerCountButton;
@property(nonatomic, strong) IBOutlet UIButton *followingCountButton;
@property(nonatomic, strong) IBOutlet UIButton *itemCountButton;

@end

@implementation ProfileVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowUserItems:) name:EVT_showUserItems object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) useUser:(User*)user {
	self.user = user;
	[self refresh];

	// 詳細情報取得
	[APP_DELEGATE beginHud];
	NSString *urlName = user.urlName;
	if (user == nil) {
		urlName = @"yuch_i";
	}
	NSString *apiPath = [NSString stringWithFormat:@"users/%@", urlName];
	NSLog(@"path: %@", apiPath);
	[[QiitaAPIClient sharedClient] getPath:apiPath parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
		[APP_DELEGATE endHud];
		
		self.user = [[User alloc] initWithDictionary:JSON];
		NSLog(@"..desc: %@", self.user.description);
		[self refresh];
		
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[APP_DELEGATE endHud];
		
		[Util showAlert:@"接続がタイムアウトしました。"];
		
		NSLog(@"fail!: %@", error.localizedDescription);
    }];
}

- (void) refresh {
	self.nameLabel.text = self.user.name;
	self.urlNameLabel.text = self.user.urlName;
	NSURL *url = [NSURL URLWithString:self.user.profileImageUrl];
	[self.pictImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"man.png"]];

	self.descriptionLabel.text = self.user.description;
	
	//R:0 G:255 B:127
	UIColor *green = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:87/255.0 alpha:1.0];

//	self.followerCountButton.backgroundColor = green;
	[self.followerCountButton setTitle:[NSString stringWithFormat:@"フォロワー: %d", self.user.followerCount] forState:UIControlStateNormal];
	[self.followingCountButton setTitle:[NSString stringWithFormat:@"フォロー: %d", self.user.followingCount] forState:UIControlStateNormal];
	[self.itemCountButton setTitle:[NSString stringWithFormat:@"投稿数: %d", self.user.itemCount] forState:UIControlStateNormal];
	
}

- (IBAction) onClickTwitter:(UIButton*)button {
	NSString *url = self.user.twitterUrl;
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (IBAction) onClickGithub:(UIButton*)button {
	NSString *url = self.user.githubUrl;
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (IBAction) onClickItems:(UIButton*)button {
	NSDictionary *params = [NSDictionary dictionaryWithObject:self.user forKey:@"user"];
	[[NSNotificationCenter defaultCenter] postNotificationName:EVT_showUserItems object:self userInfo:params];
}

- (void) onShowUserItems:(NSNotification*)ntf {
	User *user = [ntf.userInfo objectForKey:@"user"];
	
	ItemListVC *itemListVC = [[ItemListVC alloc] init];
	[self.navigationController pushViewController:itemListVC animated:YES];
	[itemListVC useUser:user];
}


@end
