//
//  PickerView.m
//  
//
//  Created by 张鹏 on 15/8/24.
//
//

#import "PickerView.h"

@implementation PickerView 


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadViews];
    }
    return self;
}

- (void)loadViews
{
    
    self.backgroundColor = [UIColor colorWithHexString:@"99cc67" alpha:1.0];
    self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    self.textColor = [UIColor colorWithWhite:0.95f alpha:0.8f];
    self.highlightedTextColor = [UIColor whiteColor];
    self.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.interitemSpacing = 50.0;
    self.fisheyeFactor = 0.001;
    self.pickerViewStyle = AKPickerViewStyle3D;
    self.maskDisabled = false;
    self.hidden = YES;
    
}


@end
