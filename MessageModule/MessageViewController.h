//
//  MessageViewController.h
//  o2o
//
//  Created by 小才 on 13-10-10.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNViewController.h"
#import "LNTableView.h"
#import "CustomCell.h"
#import "MessageBean.h"
#import "ChatViewController.h"
@interface MessageViewController : LNViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) LNTableView *listTableView;
@property (nonatomic,strong) MessageBean *bean;

@end
