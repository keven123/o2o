//
//  SystemTool.m
//  o2o
//
//  Created by 小才 on 13-8-21.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "SystemTool.h"

@implementation SystemTool

@synthesize bean;

+ (id)sharedInstance
{
    static SystemTool *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(void) {
        sharedSingleton = [[self alloc] initialize];
    });
    return sharedSingleton;
}

-(id)initialize
{
    if(self == [super init] )
    {
        bean = [[UserBean alloc]init];
        //initial something here
    }
    return self;
}

+ (void)requestLogin
{
    SystemTool *tool = [SystemTool sharedInstance];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    //_userField.text = [userDefault objectForKey:@"user"];
    //_pwdField.text = [userDefault objectForKey:@"password"];
    NSDictionary *dicts = [[NSDictionary alloc] initWithObjectsAndKeys:@"login",@"act",[userDefault objectForKey:@"user"],@"user",[userDefault objectForKey:@"password"],@"pwd",@"0",@"vendor", nil];
    [tool HttpRequest:USER_URL params:dicts];
}

- (void)HttpRequest:(NSString *)urlString params:(NSDictionary *)dicts
{
    NSLog(@"%@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"uniapp" forKey:@"REQUEST_METHOD"];
    NSEnumerator *enumerator = [dicts keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        //NSLog(@"----------Key:%@,Value:%@",key,[dicts objectForKey:key]);
        [request setPostValue:[dicts objectForKey:key] forKey:key];
    }
    [request setDelegate:self];
    [request startAsynchronous];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *responseString = [request responseString];
    NSLog(@"requestFinished:%@",responseString);
    NSDictionary *dct = [responseString objectFromJSONString];
    bean = [[UserBean alloc]initWithDictionary:dct];
}


- (NSString *)getUserId
{
    return bean.userid;
}

- (NSString *)getUserName
{
    return bean.username;
}

- (void)clearUserSession
{
    bean = nil;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:nil forKey:@"user"];
    [userDefault setObject:nil forKey:@"password"];
}

//判断是否登陆
+ (BOOL)isLogin
{
    SystemTool *tool = [SystemTool sharedInstance];
    if ([[[tool bean] userInfo] userid] != nil && ![[[[tool bean] userInfo] userid] isEqualToString:@"null"]) {
        return YES;
    }
    return NO;
}

@end
