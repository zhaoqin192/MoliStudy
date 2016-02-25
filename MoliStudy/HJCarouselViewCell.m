//
//  HJCarouselViewCell.m
//  HJCarouselDemo
//
//  Created by haijiao on 15/8/20.
//  Copyright (c) 2015年 olinone. All rights reserved.
//

#import "HJCarouselViewCell.h"

@implementation HJCarouselViewCell

- (void)awakeFromNib {
    // Initialization code
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
