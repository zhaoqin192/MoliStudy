//
//  TableViewHeader.m
//  MoliStudy
//
//  Created by 王霄 on 15/11/26.
//  Copyright © 2015年 MoliStudy. All rights reserved.
//

#import "TableViewHeader.h"

@implementation TableViewHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f8f8ee" alpha:1.0];
        _open = NO;
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.bounds;
        [_button addTarget:self action:@selector(doSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        _cicleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cicleButton.frame = CGRectMake(0, 0, frame.size.height/3*2, frame.size.height/3*2);
        [_cicleButton setCenterY:self.centerY];
        [_cicleButton setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
        [_cicleButton setImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateSelected];
        [_button addSubview:_cicleButton];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height)];
        [_titleLabel setX:_cicleButton.right];
        [_titleLabel setCenterY:self.centerY];
        [_titleLabel setWidth:ScreenWidth - _titleLabel.frame.origin.x-5];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        _titleLabel.text = @"";
        [_button addSubview:_titleLabel];

    }
    return self;
}

-(void)doSelected{
    //    [self setImage];
  //  NSLog(@"do select");
    if (_delegate && [_delegate respondsToSelector:@selector(selectedWith:)]){
        [_delegate selectedWith:self];
    }
}

@end
