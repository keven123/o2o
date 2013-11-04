//
//  UserLoginViewController.h
//  o2o
//
//  Created by 小才 on 13-8-21.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNViewController.h"
#import "UserBean.h"
@interface UserLoginViewController : LNViewController<UITextFieldDelegate,delegate>

@property (nonatomic,strong) UserBean *bean;

@end
