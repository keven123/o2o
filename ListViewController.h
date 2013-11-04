//
//  MainViewController.h
//  o2o
//
//  Created by 小才 on 13-7-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "MenuViewController.h"
#import "LNTableView.h"
#import "SRRefreshView.h"
#import "SearchResultViewController.h"

@interface ListViewController : LNViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SRRefreshDelegate>

@property (nonatomic,strong) MenuViewController *menuVC;
@property (nonatomic,strong) LNTableView *listTableView;
@property (nonatomic,strong) SRRefreshView *slimeView;
@property (nonatomic,strong) ListResultBean *bean;

@end
