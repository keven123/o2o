//
//  EditViewController.m
//  o2o
//
//  Created by 小才 on 13-10-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "EditViewController.h"
#define TEXT_PADDING 10.0f

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize cid;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        textField = [[UITextField alloc]initWithFrame:CGRectMake(TEXT_PADDING, TEXT_PADDING, self.view.frame.size.width - TEXT_PADDING, self.view.frame.size.height - TEXT_PADDING)];
        [textField setPlaceholder:@"写下一些你的评论"];
        [textField setTextAlignment:NSTextAlignmentLeft];
        [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [scrollView addSubview:textField];
        [self.view addSubview:scrollView];
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
    
    //添加右导航按钮
    UIBarButtonItem *rightB = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onSend:)];
    self.navigationItem.rightBarButtonItem = rightB;
	// Do any additional setup after loading the view.
    self.title = @"撰写评论";

}

- (void)viewWillAppear:(BOOL)animated
{
    [textField becomeFirstResponder];
}

//关闭
- (void)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//发送评论
- (void)onSend:(id)sender
{
    if ([textField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"评论内容不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.view addSubview:alert];
        [alert show];
        return;
    }
    SystemTool *tool = [SystemTool sharedInstance];
    NSLog(@"cid:%@,uid:%@,content:%@",cid,[[[tool bean] userInfo] userid],textField.text);
    [self HttpRequest:TASK_COMMENT_URL params:[NSDictionary dictionaryWithObjectsAndKeys:cid,@"tid",[[[tool bean] userInfo] userid],@"uid",textField.text,@"content", nil] isUseIndicator:NO];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [super requestFinished:request];
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
    NSDictionary *dct = [responseString objectFromJSONString];
    if ([[dct objectForKey:@"result"] isEqualToString:@"000"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"发送失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.view addSubview:alert];
        [alert show];
    }
}

- (void)dealloc
{
    cid = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
