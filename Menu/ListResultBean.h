//
//  ListResultBean.h
//  o2o
//
//  Created by 小才 on 13-8-23.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "Jastor.h"

@interface ListResultBean : Jastor

@property (nonatomic,assign) NSInteger result;
@property (nonatomic,strong) NSArray *list;

@end
