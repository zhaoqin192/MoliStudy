//
//  CollectionViewCell.m
//  collectionView
//
//  Created by shikee_app05 on 14-12-10.
//  Copyright (c) 2014年 shikee_app05. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        MDRadialProgressTheme *theme = [[MDRadialProgressTheme alloc] init];
        theme.completedColor = [UIColor colorWithRed:0.94 green:0.63 blue:0.64 alpha:1];
        self.imgView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-10, frame.size.width-10) andTheme:theme];
        self.imgView.progressTotal = 100;
        self.imgView.progressCounter = 68;
        self.imgView.theme.sliceDividerHidden = YES;
        self.imgView.label.hidden = YES;
        [self addSubview:self.imgView];
        
        self.pointLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame)-10, 20)];
        self.gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame)-10, 20)];
        self.pointLabel.text = @"句间逻辑";
        [self.pointLabel setBottom:self.imgView.y + self.imgView.height/2 -5];
        self.pointLabel.textAlignment = NSTextAlignmentCenter;
        self.gradeLabel.text = @"68";
        [self.gradeLabel setTop:self.imgView.y + self.imgView.height/2 + 8];
        self.gradeLabel.textAlignment = NSTextAlignmentCenter;
        self.gradeLabel.font = [UIFont systemFontOfSize:24];
        self.pointLabel.font = [UIFont systemFontOfSize:16];
        self.gradeLabel.textColor = [UIColor colorWithRed:0.94 green:0.63 blue:0.64 alpha:1];
        self.pointLabel.textColor = [UIColor whiteColor];
        [self setLabel:_pointLabel];
        [self setLabel:_gradeLabel];
        
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame)-10, 20)];
        [self.text setTextColor:[UIColor whiteColor]];
        self.text.text = @"+10";
        self.text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.text];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (UILabel *)setLabel:(UILabel *)label{

    label.numberOfLines = 0;
    
    [self addSubview:label];
    
    return label;
}

@end
