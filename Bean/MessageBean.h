//
//  MessageBean.h
//  o2o
//
//  Created by 小才 on 13-10-10.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "Jastor.h"

@interface MessageBean : Jastor

@property (nonatomic,assign) NSInteger result;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSString *user;
@property (nonatomic,strong) NSString *u_id;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSArray *comment;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *time;


@end
