//
//  ScrollerView.m
//  
//
//  Created by 张鹏 on 15/8/24.
//
//

#import "ScrollerView.h"

@implementation ScrollerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"ebe6d0" alpha:1.0];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self addAllviews];
    }
    return self;
}


- (void)addAllviews
{
    self.textLabel = [[MCTopAligningLabel alloc] initWithFrame:CGRectMake(5, 5, ScreenWidth-10, 70/667. *ScreenHeight)];
    _textLabel.numberOfLines = 0;
    _textLabel.backgroundColor = [UIColor colorWithHexString:@"ebe6d0" alpha:1.0];
    [self addSubview:_textLabel];
}

- (void)updateScrollViewText:(NSString*)text AttributeString:(NSMutableAttributedString*)attributeString{
    _textLabel.text = text;
    if (attributeString) {
        _textLabel.attributedText = attributeString;
    }
    self.contentSize = CGSizeMake(ScreenWidth,CGRectGetMaxY(self.textLabel.frame) + 20);
}



@end
