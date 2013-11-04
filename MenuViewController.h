//
//  MenuViewController.h
//  o2o
//
//  Created by 小才 on 13-7-30.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNViewController.h"
#import "LNTableView.h"
#import "CustomCell.h"
@interface MenuViewController : LNViewController<UITableViewDataSource,UITableViewDelegate>
    
@property (nonatomic,strong) LNTableView *lnTableView;

@end
