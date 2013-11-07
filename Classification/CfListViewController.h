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
#import <CoreLocation/CoreLocation.h>
#define EACH_PAGE_NUM @"10"
enum {
    //以下是枚举成员 TestA = 0,
    //@"私活外快";
    selfStyle = 9,
    //@"二手转让";
    secondStyle,
    //vc.title = @"百科问题";
    problemStyle,
    //@"友情帮手";
    friendStyle,
};
@interface CfListViewController : LNViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>

@property (nonatomic,strong) LNTableView *listTableView;
@property (nonatomic) int style;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end
