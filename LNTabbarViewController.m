//
//  tabbarViewController.m
//  tabbarTest
//
//  Created by Kevin Lee on 13-5-6.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import "LNTabbarViewController.h"
#import "LNTabbarView.h"
#import "ListViewController.h"
#import "LNNavViewController.h"
#import "DDMenuController.h"
#import "CfViewController.h"
#import "SendViewController.h"
#import "SystemTool.h"
#import "UserInfoViewController.h"
#import "UserLoginViewController.h"
#import "MessageViewController.h"
#define SELECTED_VIEW_CONTROLLER_TAG 98456345

@interface LNTabbarViewController ()

@end

@implementation LNTabbarViewController
@synthesize tabbar,arrayViewcontrollers;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGFloat orginHeight = SCREEN_HEIGHT - 63;
    if (iPhone5) {
        //orginHeight = self.view.frame.size.height - 63 + addHeight;
        orginHeight = SCREEN_HEIGHT - 63;
        
    }
    self.tabbar = [[LNTabbarView alloc]initWithFrame:CGRectMake(0,  orginHeight, SCREEN_WIDTH, 63)];
    self.tabbar.delegate = self;
    [self.view addSubview:tabbar];
    
    arrayViewcontrollers = [self getViewcontrollers];
    [self touchBtnAtIndex:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchBtnAtIndex:(NSInteger)index
{
    if (index == 3) {
        if (![SystemTool isLogin]) {
            UserLoginViewController *vc = [[UserLoginViewController alloc]init];
            LNNavViewController *nv = [[LNNavViewController alloc]initWithRootViewController:vc];
            self.modalPresentationStyle = UIModalPresentationPageSheet;
            [self presentViewController:nv animated:YES completion:nil];
            return;
        }else{
            UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
            [currentView removeFromSuperview];
            NSDictionary* data = [arrayViewcontrollers objectAtIndex:index];
            UINavigationController *viewController = data[@"viewController"];
            viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
            viewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height - 45);
            [self.view insertSubview:viewController.view belowSubview:tabbar];
        }
    }
    if (index < 4) {
        UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
        [currentView removeFromSuperview];
        NSDictionary* data = [arrayViewcontrollers objectAtIndex:index];
        UINavigationController *viewController = data[@"viewController"];
        viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
        viewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height - 45);
        [self.view insertSubview:viewController.view belowSubview:tabbar];
    }else{
        if (![SystemTool isLogin]) {
            UserLoginViewController *vc = [[UserLoginViewController alloc]init];
            LNNavViewController *nv = [[LNNavViewController alloc]initWithRootViewController:vc];
            self.modalPresentationStyle = UIModalPresentationPageSheet;
            [self presentViewController:nv animated:YES completion:nil];
            return;
        }else{
            SendViewController *vc = [[SendViewController alloc]init];
            LNNavViewController *nv = [[LNNavViewController alloc]initWithRootViewController:vc];
            self.modalPresentationStyle = UIModalPresentationPageSheet;
            [self presentViewController:nv animated:YES completion:nil];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}


- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationPortrait;
}

-(NSArray *)getViewcontrollers
{
    NSArray* tabBarItems = nil;
    ListViewController *frist = [[ListViewController alloc]init];
    LNNavViewController *fristNav = [[LNNavViewController alloc]initWithRootViewController:frist];
    
    CfViewController *third = [[CfViewController alloc]init];
    LNNavViewController *thirdNav = [[LNNavViewController alloc]initWithRootViewController:third];
    
    UserInfoViewController *uic = [[UserInfoViewController alloc]init];
    LNNavViewController *uic_nav = [[LNNavViewController alloc]initWithRootViewController:uic];
    
    MessageViewController *mVC = [[MessageViewController alloc]init];
    LNNavViewController *mes_nav = [[LNNavViewController alloc]initWithRootViewController:mVC];
    tabBarItems = [NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", fristNav, @"viewController",@"分类信息",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", thirdNav, @"viewController",@"主页",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", mes_nav, @"viewController",@"信息",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", uic_nav, @"viewController",@"个人信息",@"title", nil],
                   nil];
    return tabBarItems;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"TabBar 出现");
    NSLog(@"此时画面的Y轴坐标:%f",self.view.frame.origin.y);
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"TabBar 消失");
    NSLog(@"此时画面的Y轴坐标:%f",self.view.frame.origin.y);
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"TabBar 即将出现");
    NSLog(@"此时画面的Y轴坐标:%f",self.view.frame.origin.y);
}

@end
