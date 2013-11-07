//
//  DetailViewController.m
//  o2o
//
//  Created by  Lion on 13-8-23.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "OtherUserViewController.h"
#import <QuartzCore/QuartzCore.h>

#define PERSON_INFO_HEIGHT 90.0f
#define CONTENT_TITLE_HEIGHT 32.0f

@interface DetailViewController (){
    BOOL isLoadComment;
    UILabel *_posLabel;
}

@end

@implementation DetailViewController

@synthesize contentView,bean,contentTableView,mapViewController,m_bean,locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"任务详情"];
        [self.view setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:97.0/255.0 blue:0.0/255.0 alpha:1]];
    }
    return self;
}

- (id)initWithBean:(ListBean *)pBean
{
    self = [super init];
    if (self) {
        self.bean = pBean;
        isLoadComment = NO;
        [self HttpRequest:MAIN_URL params:[NSDictionary dictionaryWithObjectsAndKeys:@"info",@"act",bean.t_id,@"id", nil] isUseIndicator:NO];
        NSLog(@"bean.t_id:%@",bean.t_id);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *rightB = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(popEditView:)];
    self.navigationItem.rightBarButtonItem = rightB;
    
    //启动定位
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:1000.0f];
    /*if (!bean) {
        return;
    }*/
	// Do any additional setup after loading the view.
    
}

//定位位置成功时回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    latituduStr = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.latitude];
    longitudeStr = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.longitude];
    if(_posLabel)[_posLabel setText:[SystemTool transPerformanceWithDistance:[NSString stringWithFormat:@"%f",[SystemTool getDistance:[latituduStr                                                                                                       floatValue] lng1:[longitudeStr floatValue] lat2:[bean.la floatValue] lng2:[bean.lo floatValue]]]]];
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

- (void)popEditView:(id)sender
{
    EditViewController *vc = [[EditViewController alloc]init];
    vc.cid = bean.t_id;
    LNNavViewController *nc = [[LNNavViewController alloc]initWithRootViewController:vc];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.viewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [app.viewController presentViewController:nc animated:YES completion:nil];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [super requestFinished:request];
    NSString *responseString = [request responseString];
    NSDictionary *dct = [responseString objectFromJSONString];
    NSLog(@"json:%@",responseString);
    if (isLoadComment) {
        m_bean = [[MessageBean alloc]initWithDictionary:dct];
        if (m_bean.comment.count == 0) {
            UILabel *label = [[UILabel alloc]init];
            [label setFrame:CGRectMake(4, contentTableView.contentSize.height - 4, SCREEN_WIDTH - 8, 40)];
            [label.layer setCornerRadius:5];
            [label setText:@"暂时没人评论,赶紧来抢板凳吧~"];
            [label setBackgroundColor:[UIColor whiteColor]];
            [label setTextColor:[UIColor grayColor]];
            [label setFont:[UIFont systemFontOfSize:12]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [contentTableView addSubview:label];
        }
        [contentTableView reloadData];
    }else{
        bean = [[ListBean alloc]initWithDictionary:[dct objectForKey:@"item"]];
        contentView = [self creatContentView];
        [locationManager startUpdatingLocation];
        contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [contentTableView setDataSource:self];
        [contentTableView setDelegate:self];
        [contentTableView setBackgroundColor:[UIColor clearColor]];
        [contentTableView setBackgroundView:nil];
        [contentTableView setSeparatorColor:[UIColor clearColor]];
        [contentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [contentTableView setShowsVerticalScrollIndicator:NO];
        contentTableView.tableHeaderView = contentView;
        [self.view addSubview:contentTableView];
        isLoadComment = YES;
        [self HttpRequest:TASK_COMMENT_URL params:[NSDictionary dictionaryWithObjectsAndKeys:bean.t_id,@"tid", nil] isUseIndicator:NO];
    }
    
}

//创建内容视图
- (UIView *)creatContentView
{
    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PERSON_INFO_HEIGHT)];
    UIImageView *headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(12.5f, 15.5f, 63.5f, 63.5f)];
    [headIcon setImage:[UIImage imageNamed:@"head_icon"]];
    [headIcon setUserInteractionEnabled:YES];
    [infoView addSubview:headIcon];
    UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 63.5f, 63.5f)];
    [headBtn addTarget:self action:@selector(openOtherUser:) forControlEvents:UIControlEventTouchUpInside];
    [headIcon addSubview:headBtn];
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(84.5f, 16.f, 232.0f, 24.0f)];
    [usernameLabel setBackgroundColor:[UIColor clearColor]];
    [usernameLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [usernameLabel setTextAlignment:NSTextAlignmentLeft];
    [usernameLabel setText:@"测试"];
    [usernameLabel setTextColor:[UIColor whiteColor]];
    [infoView addSubview:usernameLabel];
    //图标
    UIImageView *smallIcon = [[UIImageView alloc]initWithFrame:CGRectMake(85.5f, 65.0f, 8.5f, 14.0f)];
    [smallIcon setImage:[UIImage imageNamed:@"pos_small_icon"]];
    [infoView addSubview:smallIcon];
    //位置距离
    UILabel *posLabel = [[UILabel alloc]initWithFrame:CGRectMake(96.5f, 65.0f, 34.0f, 14.0f)];
    [posLabel setBackgroundColor:[UIColor clearColor]];
    [posLabel setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [posLabel setAdjustsFontSizeToFitWidth:YES];
    [posLabel setTextColor:[UIColor whiteColor]];
    _posLabel = posLabel;
    [infoView addSubview:posLabel];
    //按钮
    UIButton *getBtn = [[UIButton alloc]initWithFrame:CGRectMake(137.0f, 61.0f, 69.5f, 21.0f)];
    [getBtn setBackgroundColor:[UIColor colorWithRed:161.0f/255.0f green:66.0f/255.0f blue:0 alpha:1]];
    [getBtn setTitle:@"获取位置" forState:UIControlStateNormal];
    [getBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getBtn setTitleColor:[UIColor colorWithRed:243.0f/255.0f green:146.0f/255.0f blue:30.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [getBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [getBtn addTarget:self action:@selector(targetWithMap:) forControlEvents:UIControlEventTouchUpInside];
    [getBtn.layer setCornerRadius:2];
    [infoView addSubview:getBtn];
    
    //描述标题
    UIView *describe = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 311.5f, 40.0f)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(11.0f, 0, 100.0f, 31.5f)];
    [titleLabel setText:bean.title];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [describe addSubview:titleLabel];
    
    //价格
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(262.0f, 0, 40.0f, 31.5f)];
    [priceLabel setText:[NSString stringWithFormat:@"$%@",bean.price]];
    [priceLabel setTextColor:[UIColor whiteColor]];
    [priceLabel setAdjustsFontSizeToFitWidth:YES];
    [priceLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [describe addSubview:priceLabel];
    
    [describe setBackgroundColor:[UIColor colorWithRed:243.0f/255.0f green:146.0f/255.0f blue:30.0f/255.0f alpha:1]];
    [describe.layer setCornerRadius:5];
    
    //描述
    UITextView *describeText = [[UITextView alloc]initWithFrame:CGRectMake(0,31.5f,311.5f,50.0f)];
    NSString *str = bean.content;
    [describeText setTextColor:[UIColor blackColor]];
    [describeText setFont:[UIFont systemFontOfSize:14]];
    if ([bean.content isEqualToString:@""]) {
        str = @"这个人很懒，什么信息都没有留下~";
        [describeText setTextAlignment:NSTextAlignmentCenter];
        [describeText setTextColor:[UIColor grayColor]];
        [describeText setFont:[UIFont systemFontOfSize:12]];
    }
    [describeText setBackgroundColor:[UIColor whiteColor]];
    [describeText setText:str];
    describeText.userInteractionEnabled = NO;
    CGRect orgRect= describeText.frame;//获取原始UITextView的frame
    CGSize  size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(311.5f, 2000) lineBreakMode:NSLineBreakByWordWrapping];
    orgRect.size.height=size.height + 10.0f;
    describeText.frame=orgRect;//重设UITextView的frame
    //描述视图
    UIView *describeView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 311.5f) / 2, 90.0f, 311.5f, describe.frame.size.height + describeText.frame.size.height)];
    [describeView addSubview:describe];
    [describeView addSubview:describeText];
    [describeView setBackgroundColor:[UIColor whiteColor]];
    [describeView.layer setCornerRadius:5];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, infoView.frame.size.height + describeView.frame.size.height)];
    [headerView addSubview:infoView];
    [headerView addSubview:describeView];
    return headerView;
}

- (void)targetWithMap:(id)sender
{
    mapViewController = [[MapViewController alloc]init];
    LNNavViewController *nv = [[LNNavViewController alloc]initWithRootViewController:mapViewController];
    MKPlacemark *placemark = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake([bean.la floatValue], [bean.lo floatValue]) addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:placemark];
    mapViewController.mapItemList = [NSArray arrayWithObject:mapItem];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.viewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [app.viewController presentViewController:nv animated:YES completion:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 312)/2, 0 , 312, 40)];
    [imageView setImage:[UIImage imageNamed:@"detail_sh_bg"]];
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(11, 11, 218, 20)];
    [numLabel setText:[NSString stringWithFormat:@"%d  评论",[m_bean.comment count]]];
    [numLabel setBackgroundColor:[UIColor clearColor]];
    [numLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [numLabel setTextColor:[UIColor whiteColor]];
    [imageView addSubview:numLabel];
    [view addSubview:imageView];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"myCell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier messageBean:[m_bean.comment objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_bean.comment count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row:%d",indexPath.row);
}

//跳转到用户信息
- (void)openOtherUser:(id)sender
{
    OtherUserViewController *vc = [[OtherUserViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
