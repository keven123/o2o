//
//  DetailCell.h
//  o2o
//
//  Created by 小才 on 13-9-11.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//
#define CELL_HEIGHT 71
#import "MessageBean.h"
#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headIcon;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UILabel *time;
@property (nonatomic,strong) MessageBean *bean;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageBean:(MessageBean *)bean;

@end
