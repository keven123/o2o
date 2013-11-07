//
//  CustomCell.m
//  o2o
//
//  Created by 小才 on 13-8-5.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "CustomCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation CustomCell
{
    UIImageView *_headImage;
    UIImageView *_smallImage;
    UILabel *_titleLable;
    UILabel *_priceLable;
    UILabel *_contentLable;
    UILabel *_posLable;
    UILabel *_commentLable;
}

@synthesize listBean,leftLabel,inputField,weiboSwitch,delegate,messageBean;

- (id)initWithBean:(ListBean *)bean indexPath:(NSIndexPath*)indexPath style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.listBean = bean;
        CGRect frame = [self frame];
        //frame.origin.y = indexPath.row * (CELL_HEIGHT/2 + 16.0f);
        frame.size = CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
        NSLog(@"frame.height:%f",[self bounds].size.height);
        CGRect bounds = [self bounds];
        bounds.size = CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
        
        //[self setBounds:frame];
        [self setFrame:frame];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_bg"]];
        frame.size.width = 312;
        frame.size.height = 94;
        frame.origin.x = (CELL_WIDTH - 312)/2;
        [imageView setFrame:frame];
        [self addSubview:imageView];
        [self createLoadView];
    }
    return self;
}

- (id)initWithMessageBean:(MessageBean *)bean indexPath:(NSIndexPath*)indexPath style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.messageBean = bean;
        CGRect frame = [self frame];
        //frame.origin.y = indexPath.row * (CELL_HEIGHT/2 + 16.0f);
        frame.size = CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
        NSLog(@"frame.height:%f",[self bounds].size.height);
        CGRect bounds = [self bounds];
        bounds.size = CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
        
        //[self setBounds:frame];
        [self setFrame:frame];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_bg"]];
        frame.size.width = 312;
        frame.size.height = 94;
        frame.origin.x = (CELL_WIDTH - 312)/2;
        [imageView setFrame:frame];
        [self addSubview:imageView];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        //添加icon
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 63, 63)];
        [headImage setImage:[UIImage imageNamed:@"head_icon"]];
        [self addSubview:headImage];
        //标题栏
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(79, 14, 163, 20)];
        [titleLable setText:@"丘志"];
        [titleLable setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [titleLable setTextColor:[UIColor colorWithRed:235.0f/255.0f green:97.0f/255.0f blue:0.0f/255.0f alpha:1]];
        [self addSubview:titleLable];
        //发表时间
        UILabel *priceLable = [[UILabel alloc]initWithFrame:CGRectMake(259, 14, 44, 20)];
        [priceLable setText:[NSString stringWithFormat:@"13-7-9"]];
        [priceLable setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [priceLable setTextColor:[UIColor colorWithRed:235.0f/255.0f green:97.0f/255.0f blue:0.0f/255.0f alpha:1]];
        [self addSubview:priceLable];
        //聊天内容
        UILabel *contentLable = [[UILabel alloc]initWithFrame:CGRectMake(79, 30, 227, 35)];
        [contentLable setText:@"电影票的期限有一个月啊，放心吧。"];
        [contentLable setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [contentLable setTextColor:[UIColor colorWithRed:82.0f/255.0f green:82.0f/255.0f blue:82.0f/255.0f alpha:1]];
        contentLable.lineBreakMode = NSLineBreakByWordWrapping;
        [contentLable setNumberOfLines:0];
        [self addSubview:contentLable];
        //[self createLoadView];
    }
    return self;
}



- (void)createLoadView
{
    //头像
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 63, 63)];
    [headImage setImageWithURL:[NSURL URLWithString:listBean.imgUrl]];
    _headImage = headImage;
    [self addSubview:headImage];
    //类型小图标
    UIImageView *smallImage = [[UIImageView alloc]initWithFrame:CGRectMake(77, 16, 17, 17)];
    [smallImage setImage:[UIImage imageNamed:@"small1_icon"]];
    _smallImage = smallImage;
    [self addSubview:smallImage];
    //标题栏
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(96, 14, 163, 20)];
    [titleLable setText:listBean.title];
    [titleLable setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [titleLable setTextColor:[UIColor colorWithRed:235.0f/255.0f green:97.0f/255.0f blue:0.0f/255.0f alpha:1]];
    _titleLable = titleLable;
    [self addSubview:titleLable];
    //价格标签
    UILabel *priceLable = [[UILabel alloc]initWithFrame:CGRectMake(259, 14, 44, 20)];
    [priceLable setText:[NSString stringWithFormat:@"￥%@",listBean.price]];
    [priceLable setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [priceLable setTextColor:[UIColor colorWithRed:235.0f/255.0f green:97.0f/255.0f blue:0.0f/255.0f alpha:1]];
    _priceLable = priceLable;
    [self addSubview:priceLable];
    //任务内容标签
    UILabel *contentLable = [[UILabel alloc]initWithFrame:CGRectMake(79, 35, 227, 35)];
    [contentLable setText:listBean.description];
    [contentLable setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [contentLable setTextColor:[UIColor colorWithRed:82.0f/255.0f green:82.0f/255.0f blue:82.0f/255.0f alpha:1]];
    contentLable.lineBreakMode = NSLineBreakByWordWrapping;
    [contentLable setNumberOfLines:0];
    _contentLable = contentLable;
    [self addSubview:contentLable];
    //位置小图标
    UIImageView *posSmallImage = [[UIImageView alloc]initWithFrame:CGRectMake(221, 76, 7, 12)];
    [posSmallImage setImage:[UIImage imageNamed:@"pos_small_icon"]];
    [self addSubview:posSmallImage];
    //位置标签
    UILabel *posLable = [[UILabel alloc]initWithFrame:CGRectMake(230, 78, 38, 9)];
    [posLable setText:[self transPerformanceWithDistance:listBean.distance]];
    [posLable setFont:[UIFont boldSystemFontOfSize:8.0f]];
    [posLable setTextColor:[UIColor colorWithRed:158.0f/255.0f green:158.0f/255.0f blue:158.0f/255.0f alpha:1]];
    _posLable = posLable;
    [self addSubview:posLable];
    //评论小图标
    UIImageView *commentSmallImage = [[UIImageView alloc]initWithFrame:CGRectMake(271, 77, 11, 11)];
    [commentSmallImage setImage:[UIImage imageNamed:@"chat_small_icon"]];
    [self addSubview:commentSmallImage];
    //评论标签
    UILabel *commentLable = [[UILabel alloc]initWithFrame:CGRectMake(284, 79, 23, 9)];
    [commentLable setText:listBean.comment];
    [commentLable setFont:[UIFont boldSystemFontOfSize:8.0f]];
    [commentLable setTextColor:[UIColor colorWithRed:158.0f/255.0f green:158.0f/255.0f blue:158.0f/255.0f alpha:1]];
    _commentLable = commentLable;
    [self addSubview:commentLable];
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self addObserver:self forKeyPath:@"listBean" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"listBean"])
    {
        [_headImage setImageWithURL:[NSURL URLWithString:listBean.imgUrl]];
        [_smallImage setImage:[UIImage imageNamed:@"small1_icon"]];
        [_titleLable setText:listBean.title];
        [_priceLable setText:[NSString stringWithFormat:@"￥%@",listBean.price]];;
        [_contentLable setText:listBean.description];
        [_posLable setText:[self transPerformanceWithDistance:listBean.distance]];
        [_commentLable setText:listBean.comment];
    }
}

- (void)updateLoadView
{
    
}


- (id)initWithCustomStyle:(CustomCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect rect = self.frame;
        rect.size.width = CUSTOM_CELL_WIDTH;
        NSLog(@"width:%f",self.frame.size.width);
        rect.origin.x = (self.frame.size.width - CUSTOM_CELL_WIDTH)/2;
        self.frame = rect;
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *cellView = [[UIView alloc]initWithFrame:rect];
        [cellView setUserInteractionEnabled:YES];
        [cellView.layer setCornerRadius:5];
        [cellView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:cellView];
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.frame.size.height)];
        [vi setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:115.0f/255.0f blue:13.0f/255.0f alpha:1]];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 60.0f, self.frame.size.height)];
        [bgView setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:115.0f/255.0f blue:13.0f/255.0f alpha:1]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70.0f, self.frame.size.height)];
        [label setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:115.0f/255.0f blue:13.0f/255.0f alpha:1]];
        [label.layer setCornerRadius:5.0f];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont boldSystemFontOfSize:11]];
        [label setTextColor:[UIColor whiteColor]];
        leftLabel = label;
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(80.0f, 0, self.frame.size.width - 100.0f, self.frame.size.height)];
        [textField setBackgroundColor:[UIColor clearColor]];
        [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [textField addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventAllTouchEvents];
        textField.delegate = self;
        inputField = textField;
        UIButton *selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(80.0f, 0, self.frame.size.width - 100.0f, self.frame.size.height)];
        [selectBtn setBackgroundColor:[UIColor clearColor]];
        [selectBtn addTarget:self action:@selector(selectReg:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *im;
        UISwitch *sw;
        switch (style) {
            case InputStyle:
                [cellView addSubview:bgView];
                [cellView addSubview:label];
                [cellView addSubview:textField];
                break;
            case SelectStyle:
                [cellView addSubview:bgView];
                [cellView addSubview:label];
                [textField setUserInteractionEnabled:NO];
                [cellView addSubview:textField];
                [cellView addSubview:selectBtn];
                break;
            case WeiboStyle:
                im = self.imageView;
                [im setImage:[UIImage imageNamed:@"sina_icon"]];
                self.textLabel.text = @"新浪微博";
                [self bringSubviewToFront:self.contentView];
                sw = [[UISwitch alloc]init];
                CGRect frame = sw.frame;
                frame.origin.x = self.frame.size.width - frame.size.width - 20;
                frame.origin.y = (self.frame.size.height - frame.size.height)/2;
                sw.frame = frame;
                [self addSubview:sw];
                break;
            default:
                break;
        }
    }
    return self;
}

-(void)hideKeyboard:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)selectReg:(id)sender
{
    self.standardIBAS = [[IBActionSheet alloc] initWithTitle:@"任务类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"私活外快" otherButtonTitles:@"二手转让", @"百科问题",@"友情帮手", nil];
    [self.standardIBAS setButtonTextColor:[UIColor blackColor]];
    [self.standardIBAS showInView:self.superview.superview.superview];
}


#pragma mark - IBActionSheet Delegate Method
- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Button at index: %d clicked\nIt's title is '%@'", buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    [inputField setText:[actionSheet buttonTitleAtIndex:buttonIndex]];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([delegate respondsToSelector:@selector(customTextFieldDidBeginEditing:)]) {
        [delegate customTextFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate customTextFieldDidEndEditing:textField];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)transPerformanceWithDistance:(NSString *)distance
{
    float distance_f = [distance floatValue];
    if (distance_f > 1000) {
        distance_f = distance_f/1000;
        return [NSString stringWithFormat:@"%.1fkm",round(distance_f*10)/10];
    }else return [NSString stringWithFormat:@"%.1fm",distance_f];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"listBean" context:NULL];
}

@end
