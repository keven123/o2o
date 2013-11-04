//
//  MenuViewController.m
//  o2o
//
//  Created by 小才 on 13-7-30.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "MenuViewController.h"
#define kMenuDisplayedWidth 276.0f
#define TABLE_HEIGHT 137.0f
@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize lnTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //首页icon
        UIImage* backImage = [UIImage imageNamed:@"home_icon"];
        CGRect backframe = CGRectMake(0,0,36,44);
        UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
        [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
        [backButton setTitle:@"" forState:UIControlStateNormal];
        backButton.titleLabel.font=[UIFont systemFontOfSize:13];
        UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        //标题
        UILabel *field = [[UILabel alloc]init];
        [field setFrame:CGRectMake(0, 0, 300, 44)];
        [field setBackgroundColor:[UIColor clearColor]];
        [field setTextColor:[UIColor whiteColor]];
        [field setText:@"返回"];
        [field setFont:[UIFont systemFontOfSize:18.0f]];
        [field setTextAlignment:NSTextAlignmentLeft];
        [field setShadowColor:[UIColor colorWithRed:217.0f/255.0f green:120.0f/255.0f blue:22.0f/255.0f alpha:1]];
        [field setShadowOffset:CGSizeMake(0, -1.0)];
        self.navigationItem.titleView = field;
        //设置背景颜色
        [self.view setBackgroundColor:[UIColor colorWithWhite:0.22f alpha:1]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    lnTableView = [[LNTableView alloc]initWithFrame:CGRectMake(0, 0, kMenuDisplayedWidth, TABLE_HEIGHT) style:UITableViewStyleGrouped];
    lnTableView.delegate = self;
    lnTableView.dataSource = self;
    [lnTableView setBackgroundView:nil];
    [self.view addSubview:lnTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"menuCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
        NSString *title;
        UIImage *image;
        switch (indexPath.row) {
            case 0:
                title = @"距离排序";
                image = [UIImage imageNamed:@"pos_icon"];
                break;
            case 1:
                title = @"报酬排序";
                image = [UIImage imageNamed:@"money_icon"];
                break;
            case 2:
                title = @"人气排序";
                image = [UIImage imageNamed:@"heart_icon"];
                break;
            default:
                break;
        }
        [cell.textLabel setText:title];
        [cell.textLabel setTextColor:[UIColor colorWithWhite:0.22f alpha:1]];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:12]];
        UIImageView *imageView = cell.imageView;
        [imageView setImage:image];
        [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"accessory"]]];
    }
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
