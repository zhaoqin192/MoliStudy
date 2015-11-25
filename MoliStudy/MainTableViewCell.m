//
//  MainTableViewCell.m
//  
//
//  Created by 张鹏 on 15/9/17.
//
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (MDRadialProgressView *)progressViewWithFrame:(CGRect)frame
{
    MDRadialProgressView *view = [[MDRadialProgressView alloc] initWithFrame:frame];
    
    return view;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        
        
        CGRect frame = CGRectMake(self.center.x - 100/375. *ScreenWidth, 30/667. *ScreenHeight, 100/375. *ScreenWidth, 100/667. *ScreenHeight);
        
        MDRadialProgressView *radialView3 = [self progressViewWithFrame:frame];
        
         [self setView:radialView3 progressTotal:365 progressCounter:365- 56];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(radialView3.frame) + 20/375. *ScreenWidth, CGRectGetMinY(radialView3.frame) + 20/667. *ScreenHeight, CGRectGetWidth(radialView3.frame) - 40/375. *ScreenWidth, 20/667. *ScreenHeight)];
      
        [self setupLabel:label1 text:@"距离考研" textColor:[UIColor lightGrayColor] font:[UIFont fontWithName:@"Helvetica" size:14]];
        
        self.labelDays = [[UILabel alloc] init];
        
        [self setUpLabel:_labelDays textColor:[UIColor colorWithHexString:@"00c195" alpha:1.0] font:[UIFont fontWithName:@"Helvetica" size:20] frame:CGRectMake(CGRectGetMinX(label1.frame), CGRectGetMaxY(label1.frame), CGRectGetWidth(label1.frame), 30/667. *ScreenHeight)];
        
        
        
        
        CGRect frame1 = CGRectMake(self.center.x + 80/375. *ScreenWidth, 30/667. *ScreenHeight, 100/375. *ScreenWidth, 100/667. *ScreenHeight);
        
        MDRadialProgressView *radialView2 = [self progressViewWithFrame:frame1];
        
        [self setView:radialView2 progressTotal:5 progressCounter:4];
        
        [self.contentView addSubview:radialView2];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(radialView2.frame) + 20/375. *ScreenWidth, CGRectGetMinY(radialView2.frame) + 20/667. *ScreenHeight, CGRectGetWidth(radialView2.frame) - 40/375. *ScreenWidth, 20/667. *ScreenHeight)];
        
        [self setupLabel:label2 text:@"今日完成" textColor:[UIColor lightGrayColor] font:[UIFont fontWithName:@"Helvetica" size:14]];
        
      self.labelTodayCount = [[UILabel alloc] init];
        
      [self setUpLabel:_labelTodayCount textColor:[UIColor colorWithHexString:@"00c195" alpha:1.0] font:[UIFont fontWithName:@"Helvetica" size:20] frame:CGRectMake(CGRectGetMinX(label2.frame), CGRectGetMaxY(label2.frame), CGRectGetWidth(label2.frame), 30/667. *ScreenHeight)];
        
    }
    
    return  self;
}

- (MDRadialProgressView *)setView:(MDRadialProgressView *)progressView progressTotal:(NSInteger)progressTotal progressCounter:(NSInteger)progressCounter
{
    
    progressView.progressTotal = progressTotal;
    progressView.progressCounter = progressCounter;
    progressView.theme.completedColor = myColor(0, 192, 150, 1.0);
    progressView.theme.incompletedColor = myColor(245, 245, 245, 1.0);
    progressView.theme.thickness = 10;
    progressView.theme.sliceDividerHidden = YES;
    progressView.label.shadowColor = [UIColor clearColor];
    progressView.label.hidden = YES;
    
    
    [self.contentView addSubview:progressView];
    
    return progressView;
    
}

-(UILabel *)setupLabel:(UILabel *)label text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font{
    
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    
    [self.contentView addSubview:label];
    
    return label;
    
}

- (UILabel *)setUpLabel:(UILabel *)label textColor:(UIColor *)textColor font:(UIFont *)font frame:(CGRect)frame{
    
    label.font = font;
    label.frame = frame;
    label.textColor = textColor;
    
    [self.contentView addSubview:label];
    
    
    return label;
}

//- (void)setModel:(HomeModel *)model
//{
//    self.labelTodayCount.text = [NSString stringWithFormat:@"%ld", model.todayCount];
//    
//    self.labelDays.text = @"56";
//    
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
