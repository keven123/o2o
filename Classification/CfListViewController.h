//
//  CfListViewController.h
//  o2o
//
//  Created by 小才 on 13-8-15.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNViewController.h"
#import "LNTableView.h"
#import "CustomCell.h"
@interface CfListViewController : LNViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) LNTableView *listTableView;

@end
