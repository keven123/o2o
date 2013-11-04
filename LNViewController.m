//
//  LNViewController.m
//  o2o
//
//  Created by 小才 on 13-7-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNViewController.h"


@interface LNViewController ()

@end

@implementation LNViewController
@synthesize myProgressIndicator,myMBProgressHUD;
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
    myProgressIndicator = [[UIProgressView alloc]init];
    [myProgressIndicator setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [myProgressIndicator setHidden:YES];
    [self.view addSubview:myProgressIndicator];
    
    myMBProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [myMBProgressHUD hide:NO];
    //UIGestureRecognizer *gestureRecognizer = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTap:)];
    //[gestureRecognizer setDelegate:self];
    //[self.view addGestureRecognizer:gestureRecognizer];
	// Do any additional setup after loading the view.
}

- (void)HttpRequest:(NSString *)urlString params:(NSDictionary *)dicts isUseIndicator:(BOOL)isUI
{
    NSLog(@"%@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"uniapp" forKey:@"REQUEST_METHOD"];
    NSEnumerator *enumerator = [dicts keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        //NSLog(@"----------Key:%@,Value:%@",key,[dicts objectForKey:key]);
        [request setPostValue:[dicts objectForKey:key] forKey:key];
    }
    if (isUI) {
        [myProgressIndicator setHidden:NO];
        [self.view bringSubviewToFront:myProgressIndicator];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
        [request setUploadProgressDelegate:myProgressIndicator];
    }else{
        [self.view bringSubviewToFront:myMBProgressHUD];
        myMBProgressHUD.mode = MBProgressHUDModeIndeterminate;
        myMBProgressHUD.labelText = @"加载";
        [myMBProgressHUD show:YES];
    }
    [request setDelegate:self];
    [request startAsynchronous];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [myMBProgressHUD hide:YES];
}

- (void)changeProgress
{
    NSLog(@"Value: %f",[myProgressIndicator progress]);
    if ([myProgressIndicator progress] >= 1) {
        [myProgressIndicator setHidden:YES];
        [myProgressIndicator setProgress:0];
        [timer invalidate];
        timer = nil;
    }
}

- (void)backgroundTap:(id)sender
{
    //[self depthResearchView:self.view];
}

- (void)depthResearchView:(id)sender
{
    UIView *mainView = sender;
    for (id view in [mainView subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
        if ([[view subviews] count] > 0) {
            [self depthResearchView:view];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

-(BOOL)shouldAutorotate
{
    return NO;
}
/*
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
*/


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [self backgroundTap:nil];
    return true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
