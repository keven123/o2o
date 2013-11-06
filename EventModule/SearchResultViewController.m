//
//  SearchResultViewController.m
//  o2o
//
//  Created by 小才 on 13-11-4.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()
{
    BOOL distanceFlag;
    BOOL priceFlag;
    BOOL popularFlag;
    NSString *latituduStr;
    NSString *longitudeStr;
}

@end

@implementation SearchResultViewController
@synthesize listTableView,bean,searchStr,locationManager;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        distanceFlag = NO;
        priceFlag = NO;
        popularFlag = NO;
        // Custom initialization
        [self addObserver:self forKeyPath:@"searchStr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加左导航按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45.0f, 30.0f)];
    [btn setBackgroundImage:[UIImage imageNamed:@"close_nav_btn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftB = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftB;
	// Do any additional setup after loading the view.
    
    //切换分类
    [self addTypeBtn];
    listTableView = [[LNTableView alloc]init];
    [listTableView setFrame:CGRectMake(0, 26, SCREEN_WIDTH, self.view.frame.size.height - 26 - NAV_HEIGHT - STATUS_BAR_HEIGHT)];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    listTableView.backgroundColor = [UIColor clearColor];
    [listTableView setShowsVerticalScrollIndicator:NO];
    [listTableView setBackgroundView:nil];
    [self.view addSubview:listTableView];
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:1000.0f];
    [locationManager startUpdatingLocation];
    
}

//定位位置成功时回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    latituduStr = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.latitude];
    longitudeStr = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.longitude];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"searchStr"])
    {
        [self setTitle:[NSString stringWithFormat:@"搜索\"%@\"",searchStr]];
        [self HttpRequest:MAIN_URL params:[NSDictionary dictionaryWithObjectsAndKeys:@"list",@"act",@"10",@"no",searchStr,@"search", nil] isUseIndicator:NO];
    }
}

- (void)orderByDistance:(id)sender
{
    UIButton *distanceBtn = (UIButton *)sender;
    if(distanceFlag){
        [distanceBtn setBackgroundImage:[UIImage imageNamed:@"distance"] forState:UIControlStateNormal];
        distanceFlag = NO;
    }else{
        [distanceBtn setBackgroundImage:[UIImage imageNamed:@"distance_over"] forState:UIControlStateNormal];
        distanceFlag = YES;
    }
    [self requestHttpData];
}

- (void)orderByPrice:(id)sender
{
    UIButton *priceBtn = (UIButton *)sender;
    if(priceFlag){
        [priceBtn setBackgroundImage:[UIImage imageNamed:@"price"] forState:UIControlStateNormal];
        priceFlag = NO;
    }else{
        [priceBtn setBackgroundImage:[UIImage imageNamed:@"price_over"] forState:UIControlStateNormal];
        priceFlag = YES;
    }
    [self requestHttpData];
}

- (void)orderByPopular:(id)sender
{
    UIButton *popularBtn = (UIButton *)sender;
    if(popularFlag){
        [popularBtn setBackgroundImage:[UIImage imageNamed:@"popular"] forState:UIControlStateNormal];
        popularFlag = NO;
    }else{
        [popularBtn setBackgroundImage:[UIImage imageNamed:@"popular_over"] forState:UIControlStateNormal];
        popularFlag = YES;
    }
    [self requestHttpData];
}

- (void)requestHttpData{
    NSString *distanceStr = [[NSString alloc]init];
    NSString *priceStr = [[NSString alloc]init];
    NSString *popularStr = [[NSString alloc]init];
    if (distanceFlag) {
        distanceStr = @"1";
    }
    if (priceFlag) {
        priceStr = @"1";
    }
    if (popularFlag){
        popularStr = @"1";
    }
    [self HttpRequest:MAIN_URL params:[NSDictionary dictionaryWithObjectsAndKeys:@"list",@"act",@"10",@"no",distanceStr,@"distance",priceStr,@"price",popularStr,@"popular",latituduStr,@"la",longitudeStr,@"lo", nil] isUseIndicator:NO];
}



//关闭
- (void)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)addTypeBtn
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 26)];
    UIButton *distanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [distanceBtn setFrame:CGRectMake(0, 0, 106, 26)];
    [distanceBtn setBackgroundImage:[UIImage imageNamed:@"distance"] forState:UIControlStateNormal];
    [distanceBtn setBackgroundImage:[UIImage imageNamed:@"distance_over"] forState:UIControlStateHighlighted];
    [view addSubview:distanceBtn];
    UIButton *priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [priceBtn setFrame:CGRectMake(106, 0, 107, 26)];
    [priceBtn setBackgroundImage:[UIImage imageNamed:@"price"] forState:UIControlStateNormal];
    [priceBtn setBackgroundImage:[UIImage imageNamed:@"price_over"] forState:UIControlStateHighlighted];
    [view addSubview:priceBtn];
    UIButton *popularBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [popularBtn setFrame:CGRectMake(213, 0, 107, 26)];
    [popularBtn setBackgroundImage:[UIImage imageNamed:@"popular"] forState:UIControlStateNormal];
    [popularBtn setBackgroundImage:[UIImage imageNamed:@"popular_over"] forState:UIControlStateHighlighted];
    [view addSubview:popularBtn];
    [self.view addSubview:view];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [bean.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"myCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc]initWithBean:[bean.list objectAtIndex:indexPath.row] indexPath:indexPath style:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"searchStr"];
}

@end
