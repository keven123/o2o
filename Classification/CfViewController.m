//
//  CfViewController.m
//  o2o
//
//  Created by 小才 on 13-8-7.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "CfViewController.h"
#import "CfListViewController.h"
#define DISTANCE_X 138.0f
#define DISTANCE_Y 165.0f
#define VIEW_WIDTH 114.5f
#define VIEW_HEIGHT 134.0f
#define BUTTON_WIDTH 114.0f
#define BUTTON_HEIGHT 111.5f
@interface CfViewController ()

@end

@implementation CfViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }*/
    [self fillBackgroundImage];
    UIView *mainView = [self fillClassBtn];
    [self.view addSubview:mainView];
    [self addLogoToNav:self.navigationItem];
    //搜索栏
    UITextField *searchText = [[UITextField alloc]initWithFrame:CGRectMake(7, 6, 162, 18)];
    UIImageView *searchView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 195, 29)];
    [searchView setImage:[UIImage imageNamed:@"search_tool"]];
    [searchView setUserInteractionEnabled:YES];
    [searchText setPlaceholder:@"搜索"];
    searchText.returnKeyType=UIReturnKeySearch;
    searchText.delegate = self;
    [searchText setFont:[UIFont systemFontOfSize:13.5f]];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [searchView addSubview:searchText];
    [titleView addSubview:searchView];
    
    [self.navigationItem setTitleView:titleView];
	// Do any additional setup after loading the view.
}

- (UIView *)fillClassBtn
{
    UIView *temp_view = [[UIView alloc]init];
    for (int i = 0; i < 4; i++) {
        UIImage *image;
        UIImage *highImage;
        CGRect frame = CGRectMake(i%2 * DISTANCE_X, i/2 * DISTANCE_Y, VIEW_WIDTH, VIEW_HEIGHT);
        NSString *title;
        switch (i) {
            case 0:
                title = @"私活外快";
                image = [UIImage imageNamed:@"btn_a"];
                highImage = [UIImage imageNamed:@"btn_a_over"];
                break;
            case 1:
                title = @"二手转让";
                image = [UIImage imageNamed:@"btn_b"];
                highImage = [UIImage imageNamed:@"btn_b_over"];
                break;
            case 2:
                title = @"百科问题";
                image = [UIImage imageNamed:@"btn_c"];
                highImage = [UIImage imageNamed:@"btn_c_over"];
                break;
            case 3:
                title = @"友情帮手";
                image = [UIImage imageNamed:@"btn_d"];
                highImage = [UIImage imageNamed:@"btn_d_over"];
                break;
            default:
                break;
        }
        UIView *view = [self creatButtonWithImage:image highlight:highImage title:title frame:frame tag:i];
        [temp_view addSubview:view];
    }
    float width = VIEW_WIDTH * 2 + (DISTANCE_X - VIEW_WIDTH);
    float height = VIEW_HEIGHT * 2 + (DISTANCE_Y - VIEW_HEIGHT);
    [temp_view setFrame:CGRectMake((SCREEN_WIDTH - width)/2, (DISPLAY_HEIGHT - height)/2, width, height)];
    return temp_view;
}

- (UIView *)creatButtonWithImage:(UIImage *)image highlight:(UIImage*)highImage title:(NSString *)title frame:(CGRect)frame tag:(NSInteger)tag
{
    UIView *view = [[UIView alloc] init];
    [view setFrame:frame];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:tag];
    [button setFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 118.0f, 114.5f, 16.0f)];
    [field setText:title];
    [field setTextAlignment:NSTextAlignmentCenter];
    [field setFont:[UIFont systemFontOfSize:12.0f]];
    [field setTextColor:[UIColor whiteColor]];
    [view addSubview:button];
    [view addSubview:field];
    return view;
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

- (void)click:(id)sender
{
    UIButton *button = (UIButton *)sender;
    CfListViewController *vc = [[CfListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navb_bg"] forBarMetrics:UIBarMetricsDefault];
    NSLog(@"%d",button.tag);
}

- (void)fillBackgroundImage
{
     //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"texture_bg"]];
    [self.view setBackgroundColor:[UIColor colorWithRed:236.0f/255.0f green:100.0f/255.0f blue:2.0f/255.0f alpha:1]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
