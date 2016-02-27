//
//  HJCarouselViewCell.m
//  HJCarouselDemo
//
//  Created by haijiao on 15/8/20.
//  Copyright (c) 2015年 olinone. All rights reserved.
//

#import "HJCarouselViewCell.h"
@interface HJCarouselViewCell()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *continueStudyButton;
@property (weak, nonatomic) IBOutlet UIButton *checkReportButton;
@property (weak, nonatomic) IBOutlet UIView *backView;


@end

@implementation HJCarouselViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backView.backgroundColor = highBlue;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.continueStudyButton.backgroundColor = ButtonOrange;
    self.checkReportButton.backgroundColor = highGreen;
}
- (IBAction)continueStudyButtonClicked {
    if (self.continueStudyButtonClickedBlock) {
        self.continueStudyButtonClickedBlock();
    }
}
- (IBAction)checkReportButtonClicked {
    if (self.checkReportButtonClickedBlock) {
        self.checkReportButtonClickedBlock();
    }
}

@end
