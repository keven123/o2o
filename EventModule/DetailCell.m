//
//  DetailCell.m
//  o2o
//
//  Created by 小才 on 13-9-11.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

@synthesize headIcon,title,content,time;
@synthesize bean = _bean;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageBean:(MessageBean *)bean
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bean = bean;
        [self setBackgroundColor:[UIColor clearColor]];
        // Initialization code
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width - 312)/2, 0, 312, CELL_HEIGHT)];
        [backgroundView setBackgroundColor:[UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1]];
        UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake((312 - 281)/2, CELL_HEIGHT - 2, 281, 2)];
        [imageLine setImage:[UIImage imageNamed:@"cell_line"]];
        [backgroundView addSubview:imageLine];
        [self addSubview:backgroundView];
        
        //头像
        headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(18, 10, 34, 34)];
        [headIcon setImage:[UIImage imageNamed:@"head_icon"]];
        [self addSubview:headIcon];
        
        //评论人姓名
        title = [[UILabel alloc]initWithFrame:CGRectMake(67, 5, 100, 20)];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setFont:[UIFont systemFontOfSize:12]];
        [title setText:bean.user];
        [title setTextColor:[UIColor blackColor]];
        [self addSubview:title];
        
        //评论内容
        content = [[UILabel alloc]initWithFrame:CGRectMake(67, 27, 100, 20)];
        [content setBackgroundColor:[UIColor clearColor]];
        [content setFont:[UIFont systemFontOfSize:12]];
        [content setText:bean.content];
        [content setTextColor:[UIColor colorWithWhite:0.36f alpha:1]];
        [self addSubview:content];
        
        //评论时间
        time = [[UILabel alloc]initWithFrame:CGRectMake(67, 50, 100, 20)];
        [time setBackgroundColor:[UIColor clearColor]];
        [time setFont:[UIFont systemFontOfSize:12]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[bean.time floatValue]];;
        NSString *nowtimeStr = [formatter stringFromDate:date];
        [time setText:nowtimeStr];
        [self addSubview:time];
        
        UIImageView *imIcon = [[UIImageView alloc]initWithFrame:CGRectMake(278, 5, 18, 17)];
        [imIcon setImage:[UIImage imageNamed:@"im_icon"]];
        [self addSubview:imIcon];
        UIView *layoutView = [[UIView alloc]initWithFrame:self.frame];
        [layoutView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailCl_bg"]]];
        self.selectedBackgroundView = layoutView;
        //self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
