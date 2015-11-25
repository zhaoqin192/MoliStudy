//
//  setFootView.h
//  
//
//  Created by 张鹏 on 15/10/12.
//
//

#import <UIKit/UIKit.h>

@interface setFootView : UIView


@property (nonatomic, strong)UISegmentedControl *segMent;

// 题型
@property (nonatomic, strong) UILabel *labelType;
// 已覆盖
@property (nonatomic, strong) UILabel *labelDid;

@property (nonatomic, strong) UIButton *buttonStudy;

@end
