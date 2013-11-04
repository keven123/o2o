//
//  AppDelegate.h
//  o2o
//
//  Created by 小才 on 13-7-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNNavViewController.h"
#import "DDMenuController.h"
#import "LNTabbarViewController.h"


@protocol delegate <NSObject>

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request;
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>



@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) id<delegate> delegate;
@property (nonatomic, strong) LNTabbarViewController *viewController;
//@property (strong, nonatomic) DDMenuController *dMC;

@end
