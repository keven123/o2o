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
#import <CoreLocation/CoreLocation.h>
#import "LoadMoreTableFooterView.h"
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
@interface ListViewController : LNViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SRRefreshDelegate,CLLocationManagerDelegate,LoadMoreTableFooterDelegate>
{
    NSString *latituduStr;
    NSString *longitudeStr;
    LoadMoreTableFooterView *_refreshFooterView;
}

@property (nonatomic,strong) MenuViewController *menuVC;
@property (nonatomic,strong) LNTableView *listTableView;
@property (nonatomic,strong) SRRefreshView *slimeView;
@property (nonatomic,strong) ListResultBean *bean;
@property (nonatomic) int style;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end
