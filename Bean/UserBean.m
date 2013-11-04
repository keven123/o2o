//
//  UserBean.m
//  o2o
//
//  Created by 小才 on 13-9-16.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "UserBean.h"

@implementation UserBean
@synthesize userid,username,userInfo,user,email,phone,addr,zip,result;

- (void)dealloc
{
    username = nil;
    userInfo = nil;
    user = nil;
    email = nil;
    phone = nil;
    addr = nil;
    zip = nil;
    userid = nil;
}

@end
