//
//  LNNavViewController.m
//  o2o
//
//  Created by 小才 on 13-7-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNNavViewController.h"

@interface LNNavViewController ()

@end

@implementation LNNavViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navb_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.barStyle = UIBarStyleBlackOpaque;
    //[self.navigationBar setTintColor:[UIColor colorWithRed:234.0/255.0 green:97.0/255.0 blue:1.0/255.0 alpha:1]];
    NSLog(@"height:%f",self.navigationBar.frame.size.height);
    
    // 为导航下方添加横线
    //[self addLineToBar];
	// Do any additional setup after loading the view.
}

- (void)addLineToBar
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置颜色，仅填充4条边
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:162.0/255.0 green:39.0/255.0 blue:0.0/255.0 alpha:1] CGColor]);
    //设置线宽为1
    CGContextSetLineWidth(ctx, 2.0);
    CGContextMoveToPoint(ctx, 0, 44);
    CGContextAddLineToPoint(ctx, 0 + self.navigationBar.frame.size.width, 44 + self.navigationBar.frame.size.height);
    CGContextStrokePath(ctx);
}

//Overwrited Super function
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController.navigationItem setHidesBackButton:YES];
    [super pushViewController:viewController animated:animated];
    if ([[self viewControllers] count] > 1) {
        /*UIImage *backButtonImage = [[UIImage imageNamed:@"back_bar_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];*/
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 0, 48, 30)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"back_bar_bg"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [viewController.navigationItem setLeftBarButtonItem: customItem];
        NSLog(@"push");
    }
    
}

- (void)pop:(id)sender
{
    [super popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
