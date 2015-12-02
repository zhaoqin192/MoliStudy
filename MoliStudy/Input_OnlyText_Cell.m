//
//  Input_OnlyText_Cell.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-4.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "Input_OnlyText_Cell.h"

@interface Input_OnlyText_Cell ()
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation Input_OnlyText_Cell

- (void)awakeFromNib
{
    // Initialization code
    _isForLoginVC = NO;
}

- (IBAction)editDidBegin:(id)sender {
}

- (IBAction)editDidEnd:(id)sender {
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.textField.text);
    }
}

- (void)configWithPlaceholder:(NSString *)phStr andValue:(NSString *)valueStr{
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:phStr? phStr: @"" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"0x999999" andAlpha:1.0]}];
    self.textField.text = valueStr;
}
- (IBAction)textValueChanged:(id)sender {
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

#pragma mark - UIView
- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.textField.font = [UIFont systemFontOfSize:17];
    self.textField.textColor = [UIColor blackColor];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;

}

- (void)prepareForReuse{
    self.isForLoginVC = NO;
    self.textField.secureTextEntry = NO;
    self.textField.userInteractionEnabled = YES;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.editDidEndBlock = nil;
}
@end
