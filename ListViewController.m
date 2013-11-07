//
//  MainViewController.m
//  o2o
//
//  Created by 小才 on 13-7-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"
#import "CustomCell.h"
#import "DetailViewController.h"

@interface ListViewController ()
{
    BOOL distanceFlag;
    BOOL priceFlag;
    BOOL popularFlag;
    int loadNum;
    BOOL pullTableIsLoadingMore;
    UIView *_titleView;
}

@end

@implementation ListViewController

@synthesize menuVC,listTableView,slimeView,bean,locationManager,style;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        distanceFlag = NO;
        priceFlag = NO;
        popularFlag = NO;
        loadNum = 0;
        // Custom initialization
        //[self.view setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:97.0/255.0 blue:0.0/255.0 alpha:1]];
    }
    return self;
}

//给导航添加侧滑栏按钮
- (void)addSlideBtnToNav:(UINavigationItem *)navigationItem
{
    UIImage* backImage = [UIImage imageNamed:@"slide_btn"];
    CGRect backframe = CGRectMake(0,0,34,44);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton setTitle:@"" forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [backButton addTarget:self action:@selector(doSlide:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    navigationItem.leftBarButtonItem = leftBarButtonItem;
}

//给导航添加刷新按钮
- (void)addReflashBtnToNav:(UINavigationItem *)navigationItem
{
    UIImage* backImage = [UIImage imageNamed:@"reflash_btn"];
    CGRect backframe = CGRectMake(0,0,34,44);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton setTitle:@"" forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:13];
    //[backButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    navigationItem.rightBarButtonItem = leftBarButtonItem;
}

//给导航添加logo
- (void)addLogoToNav:(UINavigationItem *)navigationItem
{
    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    //CGRect logoframe = CGRectMake(0, 0, 99, 44);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:logoImage];
    [logoImageView setFrame:CGRectMake(0, 0, 99, 44)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:logoImageView];
    [navigationItem setLeftBarButtonItem:leftItem];
}


- (void)doSlide:(id)sender
{
    /*if ([[[self parentViewController]parentViewController] isKindOfClass:[DDMenuController class]]) {
        DDMenuController *dMC = (DDMenuController*)[[self parentViewController] parentViewController];
        [dMC showLeftController:YES];
    }*/
    //AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    //[delegate.dMC showLeftController:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationPortrait;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self addSlideBtnToNav:self.navigationItem];
    //[self addReflashBtnToNav:self.navigationItem];
    [self addLogoToNav:self.navigationItem];
    
    //搜索栏
    UITextField *searchText = [[UITextField alloc]initWithFrame:CGRectMake(7, 6, 162, 18)];
    UIImageView *searchView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 195, 29)];
    [searchView setImage:[UIImage imageNamed:@"search_tool"]];
    [searchView setUserInteractionEnabled:YES];
    [searchText setPlaceholder:@"搜索"];
    searchText.returnKeyType=UIReturnKeySearch;
    searchText.delegate = self;
    searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [searchText setFont:[UIFont systemFontOfSize:13.5f]];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    _titleView = titleView;
    [searchView addSubview:searchText];
    [titleView addSubview:searchView];
    
    [self.navigationItem setTitleView:titleView];
    
    listTableView = [[LNTableView alloc]init];
    [listTableView setFrame:CGRectMake(0, 26, SCREEN_WIDTH, DISPLAY_HEIGHT - 26)];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    listTableView.backgroundColor = [UIColor clearColor];
    [listTableView setShowsVerticalScrollIndicator:NO];
    [listTableView setBackgroundView:nil];
    [self.view addSubview:listTableView];
    
    
    //切换分类
    [self addTypeBtn];
    
    slimeView = [[SRRefreshView alloc] init];
    slimeView.delegate = self;
    slimeView.upInset = 2;
    slimeView.slimeMissWhenGoingBack = YES;
    slimeView.slime.bodyColor = [UIColor colorWithRed:234.0/255.0 green:97.0/255.0 blue:1.0/255.0 alpha:1];
    slimeView.slime.skinColor = [UIColor whiteColor];
    slimeView.slime.lineWith = 2;
    slimeView.slime.shadowBlur = 0;
    slimeView.slime.shadowColor = [UIColor blackColor];
    
    [listTableView addSubview:slimeView];
    
    
    //启动定位
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:1000.0f];
    [locationManager startUpdatingLocation];
    
    //[listTableView scrollRectToVisible:CGRectMake(0, -32.0f, 0, 0) animated:YES];
    [self addObserver:self forKeyPath:@"style" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
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

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [super requestFinished:request];
    NSString *responseString = [request responseString];
    NSLog(@"json:%@",responseString);
    NSDictionary *dct = [responseString objectFromJSONString];
    if (pullTableIsLoadingMore) {
        ListResultBean *_bean = [[ListResultBean alloc]initWithDictionary:dct];
        if (_bean.result == 0) {
            NSLog(@"加载更多");
            NSMutableArray *array = [[NSMutableArray alloc]initWithArray:bean.list];
            [array addObjectsFromArray:_bean.list];
            bean.list = array;
            loadNum += _bean.list.count;
        }
    }else{
        bean = [[ListResultBean alloc]initWithDictionary:dct];
        loadNum += bean.list.count;
    }
    [listTableView reloadData];
    [slimeView endRefresh];
    if (_refreshFooterView == nil) {
        LoadMoreTableFooterView *footview = [[LoadMoreTableFooterView alloc]initWithFrame:CGRectMake(0.0f, listTableView.bounds.size.height, self.view.frame.size.width, listTableView.bounds.size.height)];
        footview.delegate = self;
        [listTableView addSubview:footview];
        _refreshFooterView = footview;
    }
    float height = MAX(listTableView.bounds.size.height, listTableView.contentSize.height);
    [_refreshFooterView setFrame:CGRectMake(0.0f, height, self.view.frame.size.width, listTableView.bounds.size.height)];
    if (pullTableIsLoadingMore) {
        pullTableIsLoadingMore = NO;
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:listTableView];
    }
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    SearchResultViewController *vc = [[SearchResultViewController alloc]init];
    NSLog(@"Text:%@",textField.text);
    vc.searchStr = textField.text;
    LNNavViewController *nv = [[LNNavViewController alloc]initWithRootViewController:vc];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.viewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [app.viewController presentViewController:nv animated:YES completion:nil];
    return YES;
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
        cell.listBean = [bean.list objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navb_bg"] forBarMetrics:UIBarMetricsDefault];
    DetailViewController *vc = [[DetailViewController alloc]initWithBean:[bean.list objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setPullTableIsLoadingMore:(BOOL)isLoadingMore
{
    if(!pullTableIsLoadingMore && isLoadingMore) {
        // If not allready loading more start refreshing
        [_refreshFooterView startAnimatingWithScrollView:listTableView];
        pullTableIsLoadingMore = YES;
    } else if(pullTableIsLoadingMore && !isLoadingMore) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:listTableView];
        pullTableIsLoadingMore = NO;
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	NSLog(@"增加");
	pullTableIsLoadingMore = YES;
    [self requestHttpData];
}

- (void)addTypeBtn
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 26)];
    UIButton *distanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [distanceBtn setFrame:CGRectMake(0, 0, 106, 26)];
    [distanceBtn setBackgroundImage:[UIImage imageNamed:@"distance"] forState:UIControlStateNormal];
    [distanceBtn setBackgroundImage:[UIImage imageNamed:@"distance_over"] forState:UIControlStateHighlighted];
    [distanceBtn addTarget:self action:@selector(orderByDistance:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:distanceBtn];
    UIButton *priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [priceBtn setFrame:CGRectMake(106, 0, 107, 26)];
    [priceBtn setBackgroundImage:[UIImage imageNamed:@"price"] forState:UIControlStateNormal];
    [priceBtn setBackgroundImage:[UIImage imageNamed:@"price_over"] forState:UIControlStateHighlighted];
    [priceBtn addTarget:self action:@selector(orderByPrice:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:priceBtn];
    UIButton *popularBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [popularBtn setFrame:CGRectMake(213, 0, 107, 26)];
    [popularBtn setBackgroundImage:[UIImage imageNamed:@"popular"] forState:UIControlStateNormal];
    [popularBtn setBackgroundImage:[UIImage imageNamed:@"popular_over"] forState:UIControlStateHighlighted];
    [popularBtn addTarget:self action:@selector(orderByPopular:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:popularBtn];
    [self.view addSubview:view];
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
    loadNum = 0;
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
    loadNum = 0;
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
    loadNum = 0;
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
    [self HttpRequest:MAIN_URL params:[NSDictionary dictionaryWithObjectsAndKeys:@"list",@"act",EACH_PAGE_NUM,@"no",[NSString stringWithFormat:@"%d",loadNum],@"fs",distanceStr,@"distance",priceStr,@"price",popularStr,@"popular",latituduStr,@"la",longitudeStr,@"lo", nil] isUseIndicator:NO];
}


#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [slimeView scrollViewDidScroll];
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [slimeView scrollViewDidEndDraging];
    [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    loadNum = 0;
    [self requestHttpData];
}

#pragma mark - LoadMoreTableViewDelegate

- (void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view
{
    [self performSelector:@selector(reloadTableViewDataSource) withObject:nil afterDelay:0.0];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
