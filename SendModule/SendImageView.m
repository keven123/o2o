//
//  SendImageView.m
//  o2o
//
//  Created by 小才 on 13-8-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "SendImageView.h"

#define IMAGE_HEIGHT 20.0f
#define IMAGE_WIDTH 20.0f

@implementation SendImageView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - IMAGE_WIDTH, self.frame.size.height - IMAGE_WIDTH, IMAGE_WIDTH, IMAGE_HEIGHT)];
        [delBtn setImage:[UIImage imageNamed:@"image_del_btn"] forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:delBtn];
    }
    return self;
}

- (void)del:(id)sender
{
    if([self.delegate respondsToSelector:@selector(touchIndex:)])
    {
        [self.delegate touchIndex:self.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
