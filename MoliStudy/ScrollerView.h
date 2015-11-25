//
//  ScrollerView.h
//  
//
//  Created by 张鹏 on 15/8/24.
//
//

#import <UIKit/UIKit.h>
#import "MCTopAligningLabel.h"

@interface ScrollerView : UIScrollView

@property (nonatomic, strong) MCTopAligningLabel *textLabel;

- (void)updateScrollViewText:(NSString*)text AttributeString:(NSMutableAttributedString*)attributeString;

@end
