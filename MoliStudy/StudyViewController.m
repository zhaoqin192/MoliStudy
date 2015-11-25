//
//  StudyViewController.m
//  MoliStudy
//
//  Created by 王霄 on 15/11/25.
//  Copyright © 2015年 MoliStudy. All rights reserved.
//

#import "StudyViewController.h"
#import "MZTimerLabel.h"
#import "ScrollerView.h"

@interface StudyViewController ()<MZTimerLabelDelegate>

@property(nonatomic, strong) MZTimerLabel *TimeCountLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) ScrollerView *TextScrollerView;

@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTimeLabel];
    [self setScrollerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTimeLabel
{
    _TimeCountLabel = [[MZTimerLabel alloc] initWithLabel:_timeLabel andTimerType:MZTimerLabelTypeStopWatch];
    [_timeLabel setTextAlignment:NSTextAlignmentCenter];
    _TimeCountLabel.frame = CGRectMake(0,0, 75/375. *ScreenWidth,44);
    _TimeCountLabel.timeFormat = @"HH:mm:ss";
    _TimeCountLabel.textColor = [UIColor whiteColor];
    [_TimeCountLabel start];
    self.navigationItem.titleView = _TimeCountLabel;
    [_TimeCountLabel setCenterX:self.view.centerX];
}

- (void)setScrollerView
{
    if (_TextScrollerView == nil) {
        self.TextScrollerView = [[ScrollerView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth,1/2.*ScreenHeight)];
        _TextScrollerView.textLabel.text = @"";
        _TextScrollerView.contentSize = CGSizeMake(ScreenWidth,CGRectGetMaxY(_TextScrollerView.textLabel.frame) + 20);
    }
        [self.view addSubview:_TextScrollerView];
}


@end
