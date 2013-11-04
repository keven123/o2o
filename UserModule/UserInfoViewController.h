//
//  UserInfoViewController.h
//  o2o
//
//  Created by 小才 on 13-9-17.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBean.h"

@interface UserInfoViewController : LNViewController<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *_usernameLabel;
}
@property (nonatomic,strong) UserBean *bean;

@end
