//
//  SendImageView.h
//  o2o
//
//  Created by 小才 on 13-8-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendImageViewDelegate <NSObject>

@optional

- (void)touchIndex:(int)index;

@end

@interface SendImageView : UIImageView

@property (assign,nonatomic) id<SendImageViewDelegate> delegate;

@end
