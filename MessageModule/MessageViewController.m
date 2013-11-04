//
//  MessageViewController.m
//  o2o
//
//  Created by 小才 on 13-10-10.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
@synthesize listTableView,bean;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"信息"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    listTableView = [[LNTableView alloc]init];
    [listTableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, DISPLAY_HEIGHT)];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    listTableView.backgroundColor = [UIColor clearColor];
    [listTableView setShowsVerticalScrollIndicator:NO];
    [listTableView setBackgroundView:nil];
    [self.view addSubview:listTableView];
	// Do any additional setup after loading the view.
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"跑到这里了");
    static NSString *CustomCellIdentifier = @"myCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc]initWithMessageBean:[bean.comment objectAtIndex:indexPath.row] indexPath:indexPath style:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
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
    ChatViewController *vc = [[ChatViewController alloc]init];
    LNNavViewController *nc = [[LNNavViewController alloc]initWithRootViewController:vc];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.viewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [app.viewController presentViewController:nc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
