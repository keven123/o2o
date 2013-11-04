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

@end

@implementation ListViewController

@synthesize menuVC,listTableView,slimeView,bean;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    //[listTableView scrollRectToVisible:CGRectMake(0, -32.0f, 0, 0) animated:YES];
    [self HttpRequest:MAIN_URL params:[NSDictionary dictionaryWithObjectsAndKeys:@"list",@"act",@"10",@"no", nil] isUseIndicator:NO];
	// Do any additional setup after loading the view.
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
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
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

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [slimeView performSelector:@selector(endRefresh)
                     withObject:nil afterDelay:3
                        inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
