//
//  tabbarViewController.h
//  tabbarTest
//
//  Created by Kevin Lee on 13-5-6.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : 0)
#define addHeight 0


@protocol tabbarDelegate <NSObject>

-(void)touchBtnAtIndex:(NSInteger)index;

@end

@class LNTabbarView;

@interface LNTabbarViewController : UIViewController<tabbarDelegate>

@property(nonatomic,strong) LNTabbarView *tabbar;
@property(nonatomic,strong) NSArray *arrayViewcontrollers;
@end



