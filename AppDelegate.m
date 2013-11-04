//
//  AppDelegate.m
//  o2o
//
//  Created by 小才 on 13-7-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"

@implementation AppDelegate
@synthesize viewController;
//@synthesize dMC;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self registThirdPlanform];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    viewController = [[LNTabbarViewController alloc]init];
    [self.window setRootViewController:viewController];
    [self.window makeKeyAndVisible];
    [SystemTool requestLogin];
    return YES;
}

- (void)registThirdPlanform
{
    //注册新浪微博
    [WeiboSDK registerApp:@"3094349739"];
    [WeiboSDK enableDebugMode:YES];
    
    //注册腾讯
    //TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:self];
    //tencentOAuth.redirectURI = @"www.qq.com";
    //NSArray *permissions =  [NSArray arrayWithObjects:@"get_user_info", @"add_share", nil];
    //[tencentOAuth authorize:permissions inSafari:NO];
    
    //注册淘宝
    //[TopIOSClient registerIOSClient:@"12642644" appSecret:@"667940bb9a433fdb13a4fe4d9c7b50b4" callbackUrl:@"appcallback://" needAutoRefreshToken:TRUE];
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WeiboSDK handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    NSLog(@"AppDelegate:didReceiveWeiboRequest");
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        if([self.delegate respondsToSelector:@selector(didReceiveWeiboRequest:)])
        {
            [self.delegate didReceiveWeiboRequest:request];
        }
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"AppDelegate:didReceiveWeiboResponse");
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if([self.delegate respondsToSelector:@selector(didReceiveWeiboResponse:)])
        {
            [self.delegate didReceiveWeiboResponse:response];
        }
    }
}

//tencent退出
- (void)tencentDidLogout
{
    
}

- (void)tencentDidLogin
{
    
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

-(void)tencentDidNotNetWork
{
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
