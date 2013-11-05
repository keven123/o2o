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
    
    //-----------------
    //判断是否由远程消息通知触发应用程序启动
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil) {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        int badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
        }
    }
    //消息推送注册
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge];
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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    //获取终端设备标识，这个标识需要通过接口发送到服务器端，服务器端推送消息到APNS时需要知道终端的标识，APNS通过注册的终端标识找到终端设备。
    NSLog(@"My token is:%@", token);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

//处理收到的消息推送
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //在此处理接收到的消息。
    NSLog(@"Receive remote notification : %@",userInfo);
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
