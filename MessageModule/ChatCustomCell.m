

#import "ChatCustomCell.h"


@implementation ChatCustomCell

@synthesize dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30.0f)];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [dateLabel setTextColor:[UIColor colorWithWhite:0.8 alpha:1]];
        [dateLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:dateLabel];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}


@end
