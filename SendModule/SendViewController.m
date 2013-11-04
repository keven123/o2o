//
//  SendViewController.m
//  o2o
//
//  Created by 小才 on 13-8-19.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "SendViewController.h"
#import "CustomCell.h"


#define HOLD_WIDTH 63.0f
#define HOLD_HEIGHT 63.0f
#define HOLD_DISX 15.0f

@interface SendViewController (){
    int target_tag;
}

@end

@implementation SendViewController
@synthesize inputTb,holdView,ac,locationManager;
@synthesize imagePickerController = _imagePickerController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:151.0/255.0 blue:37.0/255.0 alpha:1]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //暂时储存图片
    imgDic = [[NSMutableDictionary alloc]init];
    //绘制界面
    UIControl *target = [[UIControl alloc] initWithFrame:self.view.frame];
    self.view = target;
    [target addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventAllTouchEvents];
    [self setTitle:@"发布任务"];
    //添加左导航按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45.0f, 30.0f)];
    [btn setBackgroundImage:[UIImage imageNamed:@"close_nav_btn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftB = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftB;
    
    //添加右导航按钮
    UIBarButtonItem *rightB = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onSend:)];
    self.navigationItem.rightBarButtonItem = rightB;
    
    //
    inputTb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 44) style:UITableViewStyleGrouped];
    [inputTb setDelegate:self];
    [inputTb setDataSource:self];
    [inputTb setBackgroundColor:[UIColor clearColor]];
    [inputTb setBackgroundView:nil];
    inputTb.sectionHeaderHeight = 0;
    inputTb.sectionHeaderHeight = 0;
    [inputTb setSectionIndexColor:[UIColor clearColor]];
    [inputTb setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [inputTb setSeparatorColor:[UIColor clearColor]];
    [inputTb setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:inputTb];
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    holdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 86.0f)];
    [self createHold];
    [inputTb setTableHeaderView:holdView];
}

- (void)viewDidAppear:(BOOL)animated
{
    ac = [[UIActivityIndicatorView alloc]init];
    [ac setCenter:CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT-TABBAR_HEIGHT-NAV_HEIGHT)/2)];
    [self.view addSubview:ac];
    //启动定位
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:1000.0f];
    [locationManager startUpdatingLocation];
    [ac startAnimating];
}

//定位位置成功时回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [ac stopAnimating];
    latituduStr = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.latitude];
    longitudeStr = [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.longitude];
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

-(void)hideKeyboard:(id)sender
{
    NSLog(@"%@",sender); 
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    float height = 216.0;
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(0, NAV_HEIGHT+STATUS_BAR_HEIGHT-height);
    frame.size = CGSizeMake(frame.size.width, frame.size.height + height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(0, NAV_HEIGHT+STATUS_BAR_HEIGHT);
    frame.size = CGSizeMake(frame.size.width, SCREEN_HEIGHT - NAV_HEIGHT - STATUS_BAR_HEIGHT);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

- (void)customTextFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + textField.superview.superview.frame.origin.y + textField.superview.superview.superview.frame.origin.y - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    [UIView animateWithDuration:animationDuration animations:^{
        if(offset > 0)
        {
            CGRect rect = CGRectMake(0.0f, -offset,width,height + offset);
            self.view.frame = rect;
        }
    }];
}

- (void)customTextFieldDidEndEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect rect = CGRectMake(0.0f, NAV_HEIGHT+STATUS_BAR_HEIGHT, self.view.frame.size.width, SCREEN_HEIGHT - NAV_HEIGHT - STATUS_BAR_HEIGHT);
        self.view.frame = rect;
    }];
    [textField resignFirstResponder];
}


- (void)createHold
{
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i * (HOLD_DISX + HOLD_WIDTH) + 11.0f, 13.0f, 63.0f, 63.0f)];
        [button setTag:i+1];
        [button setBackgroundImage:[UIImage imageNamed:@"hold_image"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showImagePickerForCamera:) forControlEvents:UIControlEventTouchUpInside];
        [holdView addSubview:button];
    }
}

- (void)showImagePickerForCamera:(id)sender
{
    UIButton *button = (UIButton *)sender;
    target_tag = button.tag - 1;
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    /*if (self.imageView.isAnimating)
    {
        [self.imageView stopAnimating];
    }
    
    if (self.capturedImages.count > 0)
    {
        [self.capturedImages removeAllObjects];
    }*/
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        /*
         The user wants to use the camera interface. Set up our custom overlay view for the camera.
         */
        imagePickerController.showsCameraControls = YES;
        
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */
        /*[[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
        self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
        imagePickerController.cameraOverlayView = self.overlayView;
        self.overlayView = nil;*/
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:image];
    NSLog(@"%@",image);
    //[self finishAndUpdate:image];
}

- (void)useImage:(UIImage *)image {

    // Create a graphics image context
    CGSize newSize = CGSizeMake(320, 480);
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    [self finishAndUpdate:newImage];
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)finishAndUpdate:(UIImage *)image
{
    SendImageView *iv = [[SendImageView alloc]initWithFrame:CGRectMake(target_tag * (HOLD_DISX + HOLD_WIDTH) + 11.0f, 13.0f, 63.0f, 63.0f)];
    NSLog(@"tag:%d",target_tag);
    [imgDic setObject:image forKey:[NSString stringWithFormat:@"%d",target_tag + 50]];
    UIButton *button = (UIButton *)[holdView viewWithTag:target_tag + 1];
    [button setHidden:YES];
    [iv setContentMode:UIViewContentModeScaleAspectFit];
    [iv setTag:target_tag + 50];
    [iv setUserInteractionEnabled:YES];
    [iv setDelegate:self];
    [iv setImage:image];
    [holdView addSubview:iv];
    self.imagePickerController = nil;
}

- (void)touchIndex:(int)index
{
    NSLog(@"index:%d",index);
    SendImageView *iv = (SendImageView *)[holdView viewWithTag:index];
    [imgDic removeObjectForKey:[NSString stringWithFormat:@"%d",index]];
    [iv removeFromSuperview];
    UIButton *button = (UIButton *)[holdView viewWithTag:index - 49];
    [button setHidden:NO];
}

//发送
- (void)onSend:(id)sender
{
    //判断是否已经定位
    if(longitudeStr == nil && latituduStr == nil)
    {
        //启动定位
        [locationManager startUpdatingLocation];
        [ac startAnimating];
        return;
    }
    //NSMutableString *imgData = [[NSMutableString alloc]init];
    //NSMutableData *imgData = [[NSMutableData alloc]init];
    NSMutableArray *imgData = [[NSMutableArray alloc]init];
    for (id obj in imgDic) {
        /*if ([imgData length] > 0) {
            [imgData appendFormat:@"|%@",[[NSString alloc] initWithData:UIImagePNGRepresentation([imgDic objectForKey:obj]) encoding:NSUTF8StringEncoding]];
        }else{
            [imgData appendFormat:@"%@",[[NSString alloc] initWithData:UIImagePNGRepresentation([imgDic objectForKey:obj]) encoding:NSUTF8StringEncoding]];
        }*/
        [imgData addObject:UIImagePNGRepresentation([imgDic objectForKey:obj])];
        //[imgData appendData:UIImagePNGRepresentation([imgDic objectForKey:obj])];
    }
    //NSLog(@"imgData:%@",imgData);
    SystemTool *tool = [SystemTool sharedInstance];
    [self HttpRequest:TASK_URL params:[NSDictionary dictionaryWithObjectsAndKeys:[[[tool bean] userInfo] userid],@"uid",titleField.text,@"title",labelField.text,@"keywords",descriField.text,@"description", priceField.text,@"price",longitudeStr,@"lo",latituduStr,@"la",imgData,@"pic",nil] isUseIndicator:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}

//关闭
- (void)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CustomCellIdentifier = @"myCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        switch (indexPath.section) {
            case 0:
                cell = [[CustomCell alloc]initWithCustomStyle:InputStyle reuseIdentifier:CustomCellIdentifier];
                cell.leftLabel.text = @"标题";
                cell.inputField.placeholder = @"1-30个字符";
                titleField = cell.inputField;
                break;
            case 1:
                cell = [[CustomCell alloc]initWithCustomStyle:SelectStyle reuseIdentifier:CustomCellIdentifier];
                cell.leftLabel.text = @"任务分类";
                cell.inputField.placeholder = @"选择任务分类";
                break;
            case 2:
                cell = [[CustomCell alloc]initWithCustomStyle:InputStyle reuseIdentifier:CustomCellIdentifier];
                cell.leftLabel.text = @"描述";
                cell.inputField.placeholder = @"描述一下你的任务";
                descriField = cell.inputField;
                break;
            case 3:
                cell = [[CustomCell alloc]initWithCustomStyle:InputStyle reuseIdentifier:CustomCellIdentifier];
                cell.leftLabel.text = @"标签";
                cell.inputField.placeholder = @"输入文本";
                labelField = cell.inputField;
                break;
            case 4:
                cell = [[CustomCell alloc]initWithCustomStyle:InputStyle reuseIdentifier:CustomCellIdentifier];
                cell.leftLabel.text = @"报酬";
                cell.inputField.placeholder = @"输入金额";
                priceField = cell.inputField;
                break;
            case 5:
                cell = [[CustomCell alloc]initWithCustomStyle:InputStyle reuseIdentifier:CustomCellIdentifier];
                cell.leftLabel.text = @"位置";
                cell.inputField.placeholder = @"请输入你的位置";
                placeField = cell.inputField;
                break;
            case 6:
                cell = [[CustomCell alloc]initWithCustomStyle:WeiboStyle reuseIdentifier:CustomCellIdentifier];
            default:
                break;
        }
    }
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
