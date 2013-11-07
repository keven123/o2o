//
//  DetailViewController.h
//  o2o
//
//  Created by  Lion on 13-8-23.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageBean.h"
#import "MapViewController.h"
#import "EditViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface DetailViewController : LNViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    NSString *latituduStr;
    NSString *longitudeStr;
}
@property (strong,nonatomic) UIView *contentView;
@property (strong,nonatomic) ListBean *bean;
@property (strong,nonatomic) MessageBean *m_bean;
@property (nonatomic,strong) UITableView *contentTableView;
@property (nonatomic,strong) MapViewController *mapViewController;
@property (nonatomic, strong) CLLocationManager *locationManager;
- (id)initWithBean:(ListBean *)pBean;
@end
