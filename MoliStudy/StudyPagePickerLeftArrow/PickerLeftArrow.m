//
//  PickerLeftArrow.m
//  StudyPage2.0
//
//  Created by lavender_molistudy on 15/6/4.
//  Copyright (c) 2015年 lavender_molistudy. All rights reserved.
//

#import "PickerLeftArrow.h"

@implementation PickerLeftArrow

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITapGestureRecognizer *leftArrowGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftArrowTapped)];
        [self addGestureRecognizer:leftArrowGesture];
    }
    
    return self;
}

- (void) leftArrowTapped
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PickerLeftArrowTapped" object:nil];
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context, rect.size.width/2, rect.size.height/4);
    CGContextAddLineToPoint(context, rect.size.width/4, rect.size.height/2);
    CGContextAddLineToPoint(context, rect.size.width/2, 3 * rect.size.height/4);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.9f alpha:0.8f].CGColor);
    CGContextStrokePath(context);
}

@end
