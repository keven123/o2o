//
//  LNViewController.h
//  o2o
//
//  Created by 小才 on 13-7-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Const.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "LNNavViewController.h"
@interface LNViewController : UIViewController<UIGestureRecognizerDelegate,ASIHTTPRequestDelegate>
{
    NSTimer *timer;
}

@property (nonatomic,strong) UIProgressView *myProgressIndicator;
@property (nonatomic,strong) MBProgressHUD *myMBProgressHUD;

- (void)HttpRequest:(NSString *)urlString params:(NSDictionary *)dicts isUseIndicator:(BOOL)isUI;

@end
