//
//  SendViewController.h
//  o2o
//
//  Created by 小才 on 13-8-19.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNViewController.h"
#import "SendImageView.h"
#import "CustomCell.h"
#import <CoreLocation/CoreLocation.h>

@interface SendViewController : LNViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SendImageViewDelegate,CLLocationManagerDelegate,CustomCellDelegate>
{
    NSString *latituduStr;
    NSString *longitudeStr;
    UITextField *titleField;
    UITextField *descriField;
    UITextField *labelField;
    UITextField *priceField;
    UITextField *placeField;
    NSMutableDictionary *imgDic;
}

@property (nonatomic,strong) UITableView *inputTb;

@property (nonatomic,strong) UIView *holdView;

@property (nonatomic) UIImagePickerController *imagePickerController;

@property (nonatomic,strong) UIActivityIndicatorView *ac;

@property (nonatomic, strong) CLLocationManager *locationManager;



@end
