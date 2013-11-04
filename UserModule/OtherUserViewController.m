//
//  OtherUserViewController.m
//  o2o
//
//  Created by 小才 on 13-9-16.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "OtherUserViewController.h"
#import <QuartzCore/QuartzCore.h>
#define PERSON_INFO_HEIGHT 90.0f
@interface OtherUserViewController ()

@end

@implementation OtherUserViewController
@synthesize bean;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"用户信息"];
        [self.view setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:97.0/255.0 blue:0.0/255.0 alpha:1]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PERSON_INFO_HEIGHT)];
    UIImageView *headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(12.5f, 15.5f, 63.5f, 63.5f)];
    [headIcon setImage:[UIImage imageNamed:@"head_icon"]];
    [infoView addSubview:headIcon];
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(84.5f, 16.f, 232.0f, 24.0f)];
    [usernameLabel setBackgroundColor:[UIColor clearColor]];
    [usernameLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [usernameLabel setTextAlignment:NSTextAlignmentLeft];
    [usernameLabel setText:@"Happy Lemon"];
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
    
    [self.view addSubview:infoView];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
