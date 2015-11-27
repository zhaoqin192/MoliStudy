//
//  ReportView.h
//  
//
//  Created by 张鹏 on 15/9/29.
//
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"

@interface ReportView : UIView

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIImageView *timeImageView;
@property (nonatomic, strong) UILabel *totalTimeLabel;

@property (nonatomic, strong) UIButton *button;

//进度条
@property (nonatomic, strong) MDRadialProgressView *view1;
//知识点名称
@property (nonatomic, strong) UILabel *label11;
@property (nonatomic, strong) MDRadialProgressView *view2;
@property (nonatomic, strong) UILabel *label12;
@property (nonatomic, strong) MDRadialProgressView *view3;
@property (nonatomic, strong) UILabel *label13;
@property (nonatomic, strong) MDRadialProgressView *view4;
@property (nonatomic, strong) UILabel *label14;

//知识点分数
@property (nonatomic, strong) UILabel *labelScore1;
@property (nonatomic, strong) UILabel *labelScore2;
@property (nonatomic, strong) UILabel *labelScore3;
@property (nonatomic, strong) UILabel *labelScore4;

//设置今日完成题数
- (void)setTotalCount:(int)count;
//设置今日任务总题数
- (void)setCountNum:(int)count;
//设置总时间
- (void)setTimeCount:(int)count;
@end
