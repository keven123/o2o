//
//  ListBean.h
//  o2o
//
//  Created by 小才 on 13-8-5.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "Jastor.h"

@interface ListBean : Jastor

@property (nonatomic,strong) NSString *t_id;
@property (strong,nonatomic) NSString *imgUrl;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSString *content;
@property (assign,nonatomic) NSInteger *type;
@property (strong,nonatomic) NSString *comment;
@property (strong,nonatomic) NSString *distance;
@property (assign,nonatomic) NSInteger *browse_num;
@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) NSString *cid;
@property (strong,nonatomic) NSString *la;
@property (strong,nonatomic) NSString *lo;

@end
