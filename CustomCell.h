//
//  CustomCell.h
//  o2o
//
//  Created by 小才 on 13-8-5.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListBean.h"
#import "MessageBean.h"
#import "IBActionSheet.h"
#define CELL_WIDTH 320.0f
#define CELL_HEIGHT 96.0f
#define CUSTOM_CELL_WIDTH 300.0f
typedef enum {
    //以下是枚举成员 TestA = 0,
    InputStyle,
    SelectStyle,
    WeiboStyle,
}CustomCellStyle;

@protocol CustomCellDelegate <NSObject>

@optional

- (void)customTextFieldDidBeginEditing:(UITextField *)textField;

- (void)customTextFieldDidEndEditing:(UITextField *)textField;

@end

@interface CustomCell : UITableViewCell<UITextFieldDelegate,IBActionSheetDelegate>

@property IBActionSheet *standardIBAS;
@property (nonatomic,strong) ListBean *listBean;
@property (nonatomic,strong) MessageBean *messageBean;
@property (nonatomic) UILabel *leftLabel;
@property (nonatomic) UITextField *inputField;
@property (nonatomic) UISwitch *weiboSwitch;
@property (nonatomic,assign) id<CustomCellDelegate> delegate;

- (id)initWithBean:(ListBean *)bean indexPath:(NSIndexPath*)indexPath style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (id)initWithMessageBean:(MessageBean *)bean indexPath:(NSIndexPath*)indexPath style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (id)initWithCustomStyle:(CustomCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
