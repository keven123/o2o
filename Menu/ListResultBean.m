//
//  ListResultBean.m
//  o2o
//
//  Created by 小才 on 13-8-23.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "ListResultBean.h"
#import "ListBean.h"

@implementation ListResultBean

@synthesize result,list;

+ (Class)list_class
{
    return [ListBean class];
}

- (void)dealloc
{
    list = nil;
}

@end
