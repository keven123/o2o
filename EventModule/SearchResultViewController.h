//
//  SearchResultViewController.h
//  o2o
//
//  Created by 小才 on 13-11-4.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNViewController.h"
#import "LNTableView.h"
#import "CustomCell.h"
#import <CoreLocation/CoreLocation.h>
@interface SearchResultViewController : LNViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,strong) ListResultBean *bean;
@property (nonatomic,strong) LNTableView *listTableView;
@property (nonatomic,strong) NSString *searchStr;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end
