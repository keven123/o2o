//
//  UserBean.h
//  o2o
//
//  Created by 小才 on 13-9-16.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "Jastor.h"

@interface UserBean : Jastor

@property (nonatomic,assign) NSInteger result;
@property (nonatomic,strong) NSString *userid;
@property (nonatomic,strong) UserBean *userInfo;
@property (strong,nonatomic) NSString *username;
@property (nonatomic,strong) NSString *user;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *addr;
@property (nonatomic,strong) NSString *zip;

@end
