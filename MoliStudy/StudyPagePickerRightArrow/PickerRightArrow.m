//
//  PickerRightArrow.m
//  StudyPage2.0
//
//  Created by lavender_molistudy on 15/6/4.
//  Copyright (c) 2015年 lavender_molistudy. All rights reserved.
//

#import "PickerRightArrow.h"

@implementation PickerRightArrow

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITapGestureRecognizer *rightArrowGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightArrowTapped)];
        [self addGestureRecognizer:rightArrowGesture];
    }
    
    return self;
}

- (void) rightArrowTapped
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PickerRightArrowTapped" object:nil];
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context, rect.size.width/2, rect.size.height/4);
    CGContextAddLineToPoint(context, 3 * rect.size.width/4, rect.size.height/2);
    CGContextAddLineToPoint(context, rect.size.width/2, 3 * rect.size.height/4);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.9f alpha:0.8f].CGColor);
    CGContextStrokePath(context);
}


@end
