//
//  UserRegViewController.m
//  o2o
//
//  Created by 小才 on 13-9-17.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "UserRegViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface UserRegViewController ()

@end

@implementation UserRegViewController
@synthesize userField = _userField;
@synthesize nameField = _nameField;
@synthesize pwdField = _pwdField;
@synthesize repwdField = _repwdField;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self regScene:self.view];
	// Do any additional setup after loading the view.
}

- (void)regScene:(UIView *)view
{
    //昵称
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 106, 80, 20)];
    [nameLabel setText:@"昵称"];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:224.0f/255.0f blue:177.0f/255.0f alpha:1]];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view addSubview:nameLabel];
    UITextField *nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(113, 105, 137, 25)];
    [nameTextField setDelegate:self];
    _nameField = nameTextField;
    [nameTextField setBackgroundColor:[UIColor whiteColor]];
    [nameTextField setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [nameTextField.layer setCornerRadius:2.0f];
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];    //左端缩进15像素
    nameTextField.leftView = leftview;
    nameTextField.leftViewMode = UITextFieldViewModeAlways;
    nameTextField.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
    nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [nameTextField setPlaceholder:@"昵称"];
    nameTextField.returnKeyType = UIReturnKeyNext;
    [view addSubview:nameTextField];
    
    //账号
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 136, 80, 20)];
    [userLabel setText:@"账号"];
    [userLabel setBackgroundColor:[UIColor clearColor]];
    [userLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:224.0f/255.0f blue:177.0f/255.0f alpha:1]];
    [userLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view addSubview:userLabel];
    UITextField *userTextField = [[UITextField alloc]initWithFrame:CGRectMake(113, 135, 137, 25)];
    [userTextField setDelegate:self];
    _userField = userTextField;
    [userTextField setBackgroundColor:[UIColor whiteColor]];
    [userTextField setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [userTextField.layer setCornerRadius:2.0f];
    UIView *leftview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];    //左端缩进15像素
    userTextField.leftView = leftview1;
    userTextField.leftViewMode = UITextFieldViewModeAlways;
    userTextField.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
    userTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [userTextField setPlaceholder:@"账号"];
    userTextField.returnKeyType = UIReturnKeyNext;
    [view addSubview:userTextField];
    
    //
    
    //密码
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 166, 80, 20)];
    [pwdLabel setText:@"密码"];
    [pwdLabel setBackgroundColor:[UIColor clearColor]];
    [pwdLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:224.0f/255.0f blue:177.0f/255.0f alpha:1]];
    [pwdLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view addSubview:pwdLabel];
    UITextField *pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(113, 165, 137, 25)];
    [pwdTextField setDelegate:self];
    _pwdField = pwdTextField;
    [pwdTextField setBackgroundColor:[UIColor whiteColor]];
    [pwdTextField setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [pwdTextField.layer setCornerRadius:2.0f];
    UIView *leftview2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];    //左端缩进15像素
    pwdTextField.leftView = leftview2;
    pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    pwdTextField.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
    pwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [pwdTextField setPlaceholder:@"密码"];
    pwdTextField.returnKeyType = UIReturnKeyNext;
    [view addSubview:pwdTextField];
    
    //确认密码
    UILabel *repwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 196, 80, 20)];
    [repwdLabel setText:@"确认密码"];
    [repwdLabel setBackgroundColor:[UIColor clearColor]];
    [repwdLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:224.0f/255.0f blue:177.0f/255.0f alpha:1]];
    [repwdLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view addSubview:repwdLabel];
    UITextField *repwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(113, 195, 137, 25)];
    [repwdTextField setDelegate:self];
    _pwdField = repwdTextField;
    [repwdTextField setBackgroundColor:[UIColor whiteColor]];
    [repwdTextField setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [repwdTextField.layer setCornerRadius:2.0f];
    UIView *leftview4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];    //左端缩进15像素
    repwdTextField.leftView = leftview4;
    repwdTextField.leftViewMode = UITextFieldViewModeAlways;
    repwdTextField.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
    repwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [repwdTextField setPlaceholder:@"确认密码"];
    repwdTextField.returnKeyType = UIReturnKeyNext;
    [view addSubview:repwdTextField];

    UIButton *fastRegBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 107)/2, 245, 107, 30)];
    [fastRegBtn setBackgroundImage:[UIImage imageNamed:@"fast_reg_btn"] forState:UIControlStateNormal];
    [fastRegBtn addTarget:self action:@selector(reg:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fastRegBtn];
}

- (void)reg:(id)sender
{
    NSDictionary *dicts = [[NSDictionary alloc] initWithObjectsAndKeys:@"login",@"act",_userField.text,@"user",_pwdField.text,@"pwd",@"0",@"vendor", nil];
    [self HttpRequest:USER_URL params:dicts isUseIndicator:NO];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求失败");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
