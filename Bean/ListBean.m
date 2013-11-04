//
//  ListBean.m
//  o2o
//
//  Created by 小才 on 13-8-5.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "ListBean.h"

@implementation ListBean

@synthesize title,imgUrl,description,content,type,comment,distance,browse_num,price,t_id,cid,la,lo;

- (void)dealloc
{
    t_id = nil;
    title = nil;
    imgUrl = nil;
    description = nil;
    content = nil;
    type = nil;
    distance = nil;
    browse_num = nil;
    price = nil;
    comment = nil;
    cid = nil;
    la = nil;
    lo = nil;
}

@end
