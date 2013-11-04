//
//  tabbarView.m
//  tabbarTest
//
//  Created by Kevin Lee on 13-5-6.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import "LNTabbarView.h"



@implementation LNTabbarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFrame:frame];
//        [self setBackgroundColor:[UIColor blueColor]];
        [self layoutView];
    }
    return self;
}

-(void)layoutView
{
    _tabbarView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_0"]];
    [_tabbarView setFrame:CGRectMake(0, 18, _tabbarView.bounds.size.width, 45)];
    [_tabbarView setUserInteractionEnabled:YES];
    
    _tabbarViewCenter = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_mainbtn_bg"]];

    _tabbarViewCenter.center = CGPointMake(self.center.x, self.bounds.size.height/2.0);
    
    [_tabbarViewCenter setUserInteractionEnabled:YES];
    
    _button_center = [UIButton buttonWithType:UIButtonTypeCustom];
    _button_center.adjustsImageWhenHighlighted = YES;
    [_button_center setBackgroundImage:[UIImage imageNamed:@"tabbar_mainbtn"] forState:UIControlStateNormal];
    [_button_center setBackgroundImage:[UIImage imageNamed:@"tabbar_mainbtn_over"] forState:UIControlStateHighlighted];
    [_button_center addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [_button_center setFrame:CGRectMake(0, 0, 58, 56)];
    
    _button_center.center =CGPointMake(_tabbarViewCenter.bounds.size.width/2.0, _tabbarViewCenter.bounds.size.height/2.0 + 4) ;
    
    [_tabbarViewCenter addSubview:_button_center];
    
    [self addSubview:_tabbarView];
    [self addSubview:_tabbarViewCenter];
    
    [self layoutBtn];

}

- (void)send:(id)sender
{
    [self.delegate touchBtnAtIndex:4];
}

-(void)layoutBtn
{
    _button_1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_button_1 setBackgroundColor:[UIColor blueColor]];
    [_button_1 setFrame:CGRectMake(0, 0, 59, 45)];
    [_button_1 setTag:101];
    [_button_1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    _button_2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button_2 setFrame:CGRectMake(61, 0, 96, 45)];
    [_button_2 setTag:102];
    [_button_2 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    _button_3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button_3 setFrame:CGRectMake(159, 0,102, 45)];
    [_button_3 setTag:103];
    [_button_3 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    _button_4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button_4 setFrame:CGRectMake(263, 0, 58, 45)];
    [_button_4 setTag:104];
    [_button_4 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [_tabbarView addSubview:_button_1];
    [_tabbarView addSubview:_button_2];
    [_tabbarView addSubview:_button_3];
    [_tabbarView addSubview:_button_4];
    
}

-(void)btn1Click:(id)sender
{
        
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 101:
        {
            [_tabbarView setImage:[UIImage imageNamed:@"tabbar_0"]];
            [self.delegate touchBtnAtIndex:0];
            break;
        }
        case 102:
        {
            [_tabbarView setImage:[UIImage imageNamed:@"tabbar_1"]];
            [self.delegate touchBtnAtIndex:1];
            break;
        }
        case 103:
            [_tabbarView setImage:[UIImage imageNamed:@"tabbar_2"]];
            [self.delegate touchBtnAtIndex:2];
            break;
        case 104:
            [_tabbarView setImage:[UIImage imageNamed:@"tabbar_3"]];
            [self.delegate touchBtnAtIndex:3];
            break;
        default:
            break;
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
