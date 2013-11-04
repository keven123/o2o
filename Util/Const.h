//
//  Const.h
//  o2o
//
//  Created by 小才 on 13-8-5.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "ListBean.h"
#import "ListResultBean.h"
#define BASE_URL @"http://uniideas.net/uniapp/"
#define USER_URL [NSString stringWithFormat:@"%@user.php",BASE_URL]
#define MAIN_URL [NSString stringWithFormat:@"%@main.php",BASE_URL]
#define TASK_URL [NSString stringWithFormat:@"%@tasks.php",BASE_URL]
#define TASK_COMMENT_URL [NSString stringWithFormat:@"%@tasks_comments.php",BASE_URL]
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define APP_RECT [UIScreen mainScreen].applicationFrame
#define NAV_HEIGHT 44
#define TABBAR_HEIGHT 44
#define DISPLAY_HEIGHT APP_RECT.size.height - 88

@interface Const : NSObject


@end
