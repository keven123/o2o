//
//  UserInfoViewController.m
//  o2o
//
//  Created by 小才 on 13-9-17.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "UserInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
#define PERSON_INFO_HEIGHT 90.0f
@interface UserInfoViewController (){
    NSArray *tableData;
}

@end

@implementation UserInfoViewController
@synthesize bean;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"个人中心"];
        [self.view setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:97.0/255.0 blue:0.0/255.0 alpha:1]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableData = [[NSArray alloc]initWithObjects:[[NSArray alloc] initWithObjects:@"我发布的任务",@"我参与的任务",@"我的收藏", @"我的资料",nil],[[NSArray alloc] initWithObjects:@"软件设置",@"推荐给好友",@"注销", nil], nil];
    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PERSON_INFO_HEIGHT)];
    UIImageView *headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(12.5f, 15.5f, 63.5f, 63.5f)];
    [headIcon setImage:[UIImage imageNamed:@"head_icon"]];
    [infoView addSubview:headIcon];
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(84.5f, 16.f, 232.0f, 24.0f)];
    [usernameLabel setBackgroundColor:[UIColor clearColor]];
    [usernameLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [usernameLabel setTextAlignment:NSTextAlignmentLeft];
    _usernameLabel = usernameLabel;
    [usernameLabel setTextColor:[UIColor whiteColor]];
    [infoView addSubview:usernameLabel];
    //图标
    UIImageView *smallIcon = [[UIImageView alloc]initWithFrame:CGRectMake(85.5f, 65.0f, 8.5f, 14.0f)];
    [smallIcon setImage:[UIImage imageNamed:@"pos_small_icon"]];
    [infoView addSubview:smallIcon];
    //位置距离
    UILabel *posLabel = [[UILabel alloc]initWithFrame:CGRectMake(96.5f, 65.0f, 34.0f, 14.0f)];
    [posLabel setText:@"1.2km"];
    [posLabel setBackgroundColor:[UIColor clearColor]];
    [posLabel setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [posLabel setAdjustsFontSizeToFitWidth:YES];
    [posLabel setTextColor:[UIColor whiteColor]];
    [infoView addSubview:posLabel];
    //按钮
    UIButton *getBtn = [[UIButton alloc]initWithFrame:CGRectMake(137.0f, 61.0f, 69.5f, 21.0f)];
    [getBtn setBackgroundColor:[UIColor colorWithRed:161.0f/255.0f green:66.0f/255.0f blue:0 alpha:1]];
    [getBtn setTitle:@"获取位置" forState:UIControlStateNormal];
    [getBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getBtn setTitleColor:[UIColor colorWithRed:243.0f/255.0f green:146.0f/255.0f blue:30.0f/255.0f alpha:1] forState:UIControlStateHighlighted];
    [getBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [getBtn.layer setCornerRadius:2];
    [infoView addSubview:posLabel];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height - NAV_HEIGHT - TABBAR_HEIGHT) style:UITableViewStyleGrouped];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setBackgroundView:nil];
    [tableView setTableHeaderView:infoView];
    [tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:tableView];
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    bean = [[[SystemTool sharedInstance] bean] userInfo];
    NSLog(@"userid:%@",bean.userid);
    [_usernameLabel setText:bean.username];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tableData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row_number = 0;
    switch (section) {
        case 0:
            row_number = 4;
            break;
        case 1:
            row_number = 3;
            break;
        default:
            break;
    }
    return row_number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
    }
    cell.textLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    //发布的任务
                    break;
                case 1:
                    //参与的任务
                    break;
                case 2:
                    //收藏
                    break;
                case 3:
                    //我的资料
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    //软件设置
                    break;
                case 1:
                    //推荐给好友
                    break;
                case 2:
                    //注销
                    
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
