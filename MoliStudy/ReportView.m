//
//  ReportView.m
//  
//
//  Created by 张鹏 on 15/9/29.
//
//

#import "ReportView.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"

@implementation ReportView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"00c195" alpha:1.0];
        
        [self loadAllViews];
    }
    return self;
}

- (void)loadAllViews
{
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.button.frame = CGRectMake(0, 0, ScreenWidth, self.frame.size.height);
    
    self.button.backgroundColor = [UIColor colorWithHexString:@"00c195" alpha:1.0];
    
    [self addSubview:_button];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20/375. *ScreenWidth, 20/667. *ScreenHeight, 40/375. *ScreenWidth, 30/667. *ScreenHeight)];
    label1.text = @"今日";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont fontWithName:@"Helvetica" size:20];
  
    
    [self.button addSubview:label1];
    
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+4, CGRectGetMinY(label1.frame) -4, 80,80)];
  
    self.label2.text = @"5";
    self.label2.textColor = [UIColor whiteColor];
    self.label2.font = [UIFont fontWithName:@"Helvetica" size:70];
    [self.button addSubview:self.label2];
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,40/375. *ScreenWidth, 30/667. *ScreenHeight)];
    self.countLabel.text = @"/10";
    self.countLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    self.countLabel.textColor = [UIColor whiteColor];
    [self.countLabel setBottom:20/667. *ScreenHeight+30/667. *ScreenHeight + 10];
    //[self.countLabel setBottom:self.label2.baselineAdjustment];
    [self.countLabel setLeft:self.label2.right + 2];
    [self.button addSubview:self.countLabel];
    
    self.totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 100/667. *ScreenWidth +8, 20/667. *ScreenHeight, 100/667. *ScreenWidth, 30/667. *ScreenHeight)];
    self.totalTimeLabel.text = @"14'33";
    self.totalTimeLabel.textColor = [UIColor whiteColor];
    self.totalTimeLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    
    [self.button addSubview:self.totalTimeLabel];
    [self.label2 setCenterY: self.totalTimeLabel.centerY];
    self.timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20/667. *ScreenHeight +1, 30/667. *ScreenHeight,30/667. *ScreenHeight)];
    [self.timeImageView setRight:ScreenWidth - 100/667. *ScreenWidth - 2-4];
    
    self.timeImageView.image = [UIImage imageNamed:@"clockGreen.png"];
    self.timeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.button addSubview:self.timeImageView];
    
//    
//    self.view1 = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(20/375. *ScreenWidth, 80/667. *ScreenHeight, 70/375. *ScreenWidth, 70/667. *ScreenHeight)];
//    
//    [self setView:self.view1 theme:_view1.theme label:_view1.label];
//    
//    self.label11 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_view1.frame) + 20/375. *ScreenWidth, CGRectGetMidY(_view1.frame) - 15/667. *ScreenHeight, 30, 20)];
//    self.labelScore1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_label11.frame), CGRectGetMaxY(_label11.frame), 30, 10)];
//    
//    [self setLabel:_labelScore1];
//    
//    [self setLabel:_label11];
//    
//    
//    self.view2 = [[MDRadialProgressView alloc] init];
//    
//    _view2.frame = CGRectMake(CGRectGetMaxX(_view1.frame) + 20/375. *ScreenWidth, 80, 70, 70);
//
//    [self setView:self.view2 theme:_view2.theme label:_view2.label];
//    
//    self.label12 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_view2.frame) + 20, CGRectGetMidY(_view2.frame) - 15, 30, 20)];
//    
//    self.labelScore2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_label12.frame), CGRectGetMaxY(_label12.frame), 30, 10)];
//    
//    [self setLabel:_labelScore2];
//    
//    [self setLabel:_label12];
//    
//    
//    
//    self.view3 = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_view2.frame) + 20/375. *ScreenWidth , 80, 70, 70)];
//    
//    [self setView:self.view3 theme:_view3.theme label:_view3.label];
//    
//    self.label13 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_view3.frame) + 20, CGRectGetMidY(_view3.frame) - 15, 30, 20)];
//    
//    self.labelScore3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_label13.frame), CGRectGetMaxY(_label13.frame), 30, 10)];
//    
//    [self setLabel:_labelScore3];
//    
//    [self setLabel:_label13];
//    
//    
//    self.view4 = [[MDRadialProgressView alloc] init];
//    self.view4.frame = CGRectMake(CGRectGetMaxX(_view3.frame) + 20/375. *ScreenWidth, 80, 70, 70);
//    
//    [self setView:self.view4 theme:_view4.theme label:_view4.label];
//
//    self.label14 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_view4.frame) + 20, CGRectGetMidY(_view4.frame) - 15, 30, 20)];
//    
//    self.labelScore4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_label14.frame), CGRectGetMaxY(_label14.frame), 30, 10)];
//    
//    [self setLabel:_labelScore4];
//  
//    [self setLabel:_label14];


}

- (MDRadialProgressView *)setView:(MDRadialProgressView *)MDRadialProgressView theme:(MDRadialProgressTheme *)theme label:(MDRadialProgressLabel *)label
{

    MDRadialProgressView.theme.thickness = 15;
    MDRadialProgressView.theme.incompletedColor = [UIColor colorWithHexString:@"ADD8E6" alpha:1.0];
    MDRadialProgressView.theme.completedColor = [UIColor yellowColor];
    MDRadialProgressView.theme.sliceDividerHidden = YES;
    MDRadialProgressView.label.hidden = YES;
    
    [self.button addSubview:MDRadialProgressView];
    
    return MDRadialProgressView;
}

- (UILabel *)setLabel:(UILabel *)label {
    
    label.font = [UIFont fontWithName:@"Helvetica" size:8];
    
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    
    [self.button addSubview:label];
    
    return label;
}

- (void)setTotalCount:(int)count{
    NSString *str = [NSString stringWithFormat:@"%d",count];
    self.label2.text = str;
}

- (void)setCountNum:(int)count{
    NSString *str = [NSString stringWithFormat:@"/%d",count];
    self.countLabel.text = str;
}

- (void)setTimeCount:(int)count{
    int minute = 0;
    int sec = 0;
    if (count >= 60) {
        minute = count / 60;
        sec = count - minute * 60;
    }
    else{
        sec = count;
    }
    NSString *str = [NSString stringWithFormat:@"%d'%d",minute,sec];
    self.totalTimeLabel.text = str;
}

@end
