//
//  ReportTableViewCell.m
//  
//
//  Created by 张鹏 on 15/7/20.
//
//

#import "ReportTableViewCell.h"

@implementation ReportTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //标题
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(50/375. *ScreenWidth, 5/667. *ScreenHeight, 50/375. *ScreenWidth, 30/667. *ScreenHeight)];
        
        [self.contentView addSubview:_nameLable];
        
        //进度条
//        _slider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nameLable.frame), CGRectGetMaxY(_nameLable.frame) + 5/667. *ScreenHeight, 100/375. *ScreenWidth, 10/667. *ScreenHeight)];
//        
//        _slider.maximumValue = 100;
//        _slider.minimumValue = 0;
//        _slider.minimumTrackTintColor = myColor(0, 192, 150, 1.0);
//        _slider.maximumTrackTintColor = [UIColor grayColor];
//        
//        //滑块无色
//        _slider.thumbTintColor = [UIColor clearColor];
//        
//        //不准拖动
//       // _slider.continuous = NO;
//        [self.contentView addSubview:_slider];
        
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nameLable.frame), CGRectGetMaxY(_nameLable.frame) + 5/667. *ScreenHeight, 100/375. *ScreenWidth, 10/667. *ScreenHeight)];
        
        _progressView.progressTintColor = myColor(0, 192, 150, 1.0);
        
      
        [self.contentView addSubview:_progressView];
        
        
        
        //进度label
        _sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_progressView.frame) + 20/375. *ScreenWidth, CGRectGetMinY(_progressView.frame) - 5/667. *ScreenHeight, 40/375. *ScreenWidth, 20/667. *ScreenHeight)];
        
        [self.contentView addSubview:_sliderLabel];
        
        //编辑图
        _editButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_sliderLabel.frame) + 100/375. *ScreenWidth, CGRectGetMinY(_sliderLabel.frame), 20/375. *ScreenWidth, 20/667. *ScreenHeight)];
        
        [self.contentView addSubview:_editButton];
        
    }
    
    return self;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
