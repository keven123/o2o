//
//  CfListViewController.m
//  o2o
//
//  Created by 小才 on 13-8-15.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "CfListViewController.h"
#import "DetailViewController.h"

@interface CfListViewController ()
{
    NSString *latituduStr;
    NSString *longitudeStr;
    ListResultBean *bean;
}

@end

@implementation CfListViewController

@synthesize listTableView,style,locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:97.0/255.0 blue:0.0/255.0 alpha:1]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.tintColor=[UIColor yellowColor];
    //[leftItem setTintColor:[UIColor colorWithRed:215.0f/255.0f green:87.0f/255.0f blue:0.0f alpha:1]];
    
    
    listTableView = [[LNTableView alloc]init];
    [listTableView setFrame:CGRectMake(0, 4, SCREEN_WIDTH, DISPLAY_HEIGHT)];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    listTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:listTableView];
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:1000.0f];
    [locationManager startUpdatingLocation];
	// Do any additional setup after loading the view.
}

//定位位置成功时回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    latituduStr = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.latitude];
    longitudeStr = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.longitude];
    [self HttpRequest:MAIN_URL params:[NSDictionary dictionaryWithObjectsAndKeys:@"list",@"act",EACH_PAGE_NUM,@"no",latituduStr,@"la",longitudeStr,@"lo", nil] isUseIndicator:NO];
    NSLog(@"经度:%@,纬度:%@",latituduStr,longitudeStr);
}

//定位发生错误时回调
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

//定位功能用户授权状态发生改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"授权状态:%d",status);
}

- (void)locationManager:(CLLocationManager *)manager
didFinishDeferredUpdatesWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bean.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"myCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc]initWithBean:nil indexPath:indexPath style:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    DetailViewController *vc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [super requestFinished:request];
    NSString *responseString = [request responseString];
    NSLog(@"json:%@",responseString);
    NSDictionary *dct = [responseString objectFromJSONString];
    bean = [[ListResultBean alloc]initWithDictionary:dct];
    [listTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
