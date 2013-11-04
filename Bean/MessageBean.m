//
//  MessageBean.m
//  o2o
//
//  Created by 小才 on 13-10-10.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "MessageBean.h"

@implementation MessageBean

@synthesize result,type,user,comment,u_id,avatar,content,time;

+ (Class)comment_class
{
    return [MessageBean class];
}

- (void)dealloc
{
    comment = nil;
    u_id = nil;
    user = nil;
    avatar = nil;
    content = nil;
    time = nil;
}

@end
