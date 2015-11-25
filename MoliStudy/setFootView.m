//
//  setFootView.m
//  
//
//  Created by 张鹏 on 15/10/12.
//
//

#import "setFootView.h"

@implementation setFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = myColor(255, 255, 224, 1.0);
        
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{
    
    NSArray *segMentArray = [[NSArray alloc] initWithObjects:@"完型填空", @"阅读理解", nil];
    
    self.segMent = [[UISegmentedControl alloc] initWithItems:segMentArray];
    
    _segMent.frame = CGRectMake(10/375. *ScreenWidth, 10/667. *ScreenHeight, 120/375. *ScreenWidth, 30/667. *ScreenHeight);
    
    
    _segMent.tintColor = [UIColor cyanColor];
    
    [self addSubview:_segMent];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(130, 90, 100, 30)];
    
    label1.text = @"句间逻辑";
    label1.font = [UIFont fontWithName:@"Arial" size:24];
    label1.textColor = myColor(0, 192, 150, 1.0);
    
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMinY(label1.frame) - 30/667. *ScreenHeight, 50/375. *ScreenWidth, 30/667. *ScreenHeight)];
    
    label2.text = @"薄弱点";
    label2.layer.borderWidth  = 1.0f;
    label2.layer.cornerRadius = 15.0f;
    label2.backgroundColor = [UIColor lightGrayColor];
    label2.font = [UIFont fontWithName:@"Arial" size:14];
    
    [self addSubview:label2];
    
    self.labelType = [[UILabel alloc] initWithFrame:CGRectMake(50/375. *ScreenWidth, CGRectGetMaxY(label1.frame) + 20/667. *ScreenHeight, 80/375. *ScreenWidth, 30/667. *ScreenHeight)];
    
    self.labelType.text = @"共26种题型";
    self.labelType.font = [UIFont fontWithName:@"Arial" size:14];
    self.labelType.textColor = [UIColor grayColor];
    [self addSubview:_labelType];
    
    
    self.labelDid = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.labelType.frame) + 100/375. *ScreenWidth, CGRectGetMinY(self.labelType.frame), CGRectGetWidth(self.labelType.frame), CGRectGetHeight(self.labelType.frame))];
    
    self.labelDid.text = @"已覆盖16种";
    
    self.labelDid.font = [UIFont fontWithName:@"Arial" size:14];
    
    self.labelDid.textColor = [UIColor grayColor];
    
    [self addSubview:_labelDid];
    
    
    self.buttonStudy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    self.buttonStudy.frame =  CGRectMake(120/375. *ScreenWidth, CGRectGetMaxY(self.labelType.frame) + 30/667. *ScreenHeight, 140/375. *ScreenWidth, 40/667. *ScreenHeight);
    
    self.buttonStudy.layer.borderWidth = 1.0f;
    
    //  self.buttonStudy.layer.borderColor = [UIColor colorWithRed:0.0f green:192.f blue:150.f alpha:1.0].CGColor;
    
    self.buttonStudy.layer.cornerRadius = 20.0f;
    
    [self.buttonStudy.layer setBorderColor:[UIColor greenColor].CGColor];
    
    [self.buttonStudy setTitle:@"开始学习" forState:UIControlStateNormal];
    
    [self.buttonStudy setTitleColor:myColor(0, 192, 150, 1.0) forState:UIControlStateNormal];
    
    self.buttonStudy.titleLabel.font = [UIFont fontWithName:@"Arial" size:26];
    
    [self addSubview:self.buttonStudy];

    
}

- (UIButton *)setButton:(UIButton *)button frame:(CGRect)frame title:(NSString *)title font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor {
    
    button.frame = frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    
    [button setBackgroundColor:myColor(0, 192, 150, 1.0)];
    
    [self addSubview:button];
    
    return button;
    
}



@end
