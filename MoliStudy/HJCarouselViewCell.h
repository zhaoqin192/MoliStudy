//
//  HJCarouselViewCell.h
//  HJCarouselDemo
//
//  Created by haijiao on 15/8/20.
//  Copyright (c) 2015年 olinone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJCarouselViewCell : UICollectionViewCell
@property (copy, nonatomic) void(^continueStudyButtonClickedBlock)();
@property (copy, nonatomic) void(^checkReportButtonClickedBlock)();
@end
