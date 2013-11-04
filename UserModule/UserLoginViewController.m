//
//  UserLoginViewController.m
//  o2o
//
//  Created by 小才 on 13-8-21.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "UserLoginViewController.h"
#import "UserRegViewController.h"
#import "UserInfoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface UserLoginViewController ()
{
    UITextField *_userField;
    UITextField *_pwdField;
    BOOL localFlag;
}

@end

@implementation UserLoginViewController
@synthesize bean;
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
    [self setTitle:@"登陆玩赚"];
    
    //添加左导航按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45.0f, 30.0f)];
    [btn setBackgroundImage:[UIImage imageNamed:@"close_nav_btn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftB = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftB;
    //UIGestureRecognizer *recognizer = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard:)];
    UIControl *target = [[UIControl alloc] initWithFrame:self.view.frame];
    self.view = target;
    [target addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchDown];
    [self loginScene:self.view];
	// Do any additional setup after loading the view.
}

- (void)loginScene:(UIView *)view
{
    //添加注释
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((view.frame.size.width - 130)/2,42,130,40)];
    [label setText:@"有问题？身边人为你服务！有能力？就玩着把钱赚了！"];
    [label setTextColor:[UIColor colorWithRed:255.0f/255.0f green:224.0f/255.0f blue:177.0f/255.0f alpha:1]];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [label setNumberOfLines:0];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [view addSubview:label];
    
    //账号
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 106, 40, 20)];
    [userLabel setText:@"账号"];
    [userLabel setBackgroundColor:[UIColor clearColor]];
    [userLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:224.0f/255.0f blue:177.0f/255.0f alpha:1]];
    [userLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view addSubview:userLabel];
    UITextField *userTextField = [[UITextField alloc]initWithFrame:CGRectMake(113, 105, 137, 25)];
    [userTextField setDelegate:self];
    _userField = userTextField;
    [userTextField setBackgroundColor:[UIColor whiteColor]];
    [userTextField setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [userTextField.layer setCornerRadius:2.0f];
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];    //左端缩进15像素
    userTextField.leftView = leftview;
    userTextField.leftViewMode = UITextFieldViewModeAlways;
    userTextField.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
    userTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [userTextField setPlaceholder:@"手机/邮箱"];
    userTextField.returnKeyType = UIReturnKeyNext;
    [view addSubview:userTextField];
    
    //密码
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 149, 40, 20)];
    [pwdLabel setText:@"密码"];
    [pwdLabel setBackgroundColor:[UIColor clearColor]];
    [pwdLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:224.0f/255.0f blue:177.0f/255.0f alpha:1]];
    [pwdLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [view addSubview:pwdLabel];
    
    UITextField *pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(113, 148, 137, 25)];
    [pwdTextField setDelegate:self];
    _pwdField = pwdTextField;
    [pwdTextField setBackgroundColor:[UIColor whiteColor]];
    [pwdTextField setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [pwdTextField.layer setCornerRadius:2.0f];
    UIView *lview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];    //左端缩进15像素
    pwdTextField.leftView = lview;
    [pwdTextField setSecureTextEntry:YES];
    pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    pwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    pwdTextField.returnKeyType = UIReturnKeyDone;
    [pwdTextField setPlaceholder:@"请输入密码"];
    [view addSubview:pwdTextField];
    
    //快速注册按钮vs登陆按钮
    UIButton *fastRegBtn = [[UIButton alloc]initWithFrame:CGRectMake(37, 191, 107, 30)];
    [fastRegBtn setBackgroundImage:[UIImage imageNamed:@"fast_reg_btn"] forState:UIControlStateNormal];
    [fastRegBtn addTarget:self action:@selector(reg:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:fastRegBtn];
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(171, 191, 107, 30)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:loginBtn];
    
    //第三方登陆
    UILabel *thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 260.0f, 320.0f, 30)];
    [thirdLabel setText:@"第三方账户登陆"];
    [thirdLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:224.0f/255.0f blue:177.0f/255.0f alpha:1]];
    [thirdLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [thirdLabel setTextAlignment:NSTextAlignmentCenter];
    [thirdLabel setBackgroundColor:[UIColor clearColor]];
    [view addSubview:thirdLabel];
    
    //UIButton *weiboBtn = [[UIButton alloc]initWithFrame:CGRectMake(79, 289, 35, 35)];
    UIButton *weiboBtn = [[UIButton alloc]initWithFrame:CGRectMake(142, 289, 35, 35)];
    [weiboBtn setBackgroundImage:[UIImage imageNamed:@"weibo_icon"] forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(weiboLogin:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:weiboBtn];
    
    UIButton *tencentBtn = [[UIButton alloc]initWithFrame:CGRectMake(142, 289, 35, 35)];
    [tencentBtn setBackgroundImage:[UIImage imageNamed:@"tencent_icon"] forState:UIControlStateNormal];
    [tencentBtn setHidden:YES];
    [view addSubview:tencentBtn];
    
    UIButton *baoBtn = [[UIButton alloc]initWithFrame:CGRectMake(205, 289, 35, 35)];
    [baoBtn setBackgroundImage:[UIImage imageNamed:@"bao_icon"] forState:UIControlStateNormal];
    [baoBtn setHidden:YES];
    [view addSubview:baoBtn];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //_userField.text = [userDefault objectForKey:@"user"];
    //_pwdField.text = [userDefault objectForKey:@"password"];
}

- (void)weiboLogin:(id)sender
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [myDelegate setDelegate:self];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

//来自微博的请求
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    NSLog(@"didReceiveWeiboRequest:%@",request);
}

//微博登陆成功回调
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"didReceiveWeiboResponse:%d",response.statusCode);
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        localFlag = NO;
        NSDictionary *dicts = [[NSDictionary alloc] initWithObjectsAndKeys:@"login",@"act",[(WBAuthorizeResponse *)response userID],@"user",@"1",@"vendor", nil];
        [self HttpRequest:USER_URL params:dicts isUseIndicator:NO];
    }
}



- (void)login:(id)sender
{
    localFlag = YES;
    NSDictionary *dicts = [[NSDictionary alloc] initWithObjectsAndKeys:@"login",@"act",_userField.text,@"user",_pwdField.text,@"pwd",@"0",@"vendor", nil];
    [self HttpRequest:USER_URL params:dicts isUseIndicator:NO];
}

- (void)reg:(id)sender
{
    UserRegViewController *vc = [[UserRegViewController alloc]init];
    vc.title = @"用户注册";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [super requestFinished:request];
    NSString *responseString = [request responseString];
    NSDictionary *dct = [responseString objectFromJSONString];
    bean = [[UserBean alloc]initWithDictionary:dct];
    if (bean.result == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"完成");
            SystemTool *tool = [SystemTool sharedInstance];
            [tool setBean:bean];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:bean.userInfo.user forKey:@"user"];
            if (localFlag) {
                [userDefault setObject:_pwdField.text forKey:@"password"];
            }
            AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [app.viewController touchBtnAtIndex:3];
        }];
    }
    NSLog(@"%@",responseString);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求失败");
}


//关闭
- (void)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    NSLog(@"ssfdss");
    float height = 216.0;
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

-(void)hideKeyboard:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == _userField) {
        [_pwdField becomeFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
