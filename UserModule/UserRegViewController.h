//
//  UserRegViewController.h
//  o2o
//
//  Created by 小才 on 13-9-17.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNViewController.h"

@interface UserRegViewController : LNViewController<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) UITextField *userField;
@property (nonatomic,strong) UITextField *pwdField;
@property (nonatomic,strong) UITextField *repwdField;
@end
