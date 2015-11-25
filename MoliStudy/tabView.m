//
//  tabView.m
//  
//
//  Created by 张鹏 on 15/7/8.
//
//

#import "tabView.h"

@implementation tabView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"f8f8ee" alpha:1.0];
        
        [self loadAllViews];
        
    }
    
    return self;
    
}


- (void)loadAllViews
{
    self.dianboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dianboButton.frame = CGRectMake(36/375. *ScreenWidth,  12/667. *ScreenHeight, 20/375. *ScreenWidth, 20/667. *ScreenHeight);
    
    [self.dianboButton setBackgroundImage:[UIImage imageNamed:@"tips"] forState:UIControlStateNormal];
    
 
    
    [self addSubview:_dianboButton];
    
    self.labelDianbo =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_dianboButton.frame), CGRectGetMaxY(_dianboButton.frame) + 10/667. *ScreenHeight, 20/375. *ScreenWidth, 10/667. *ScreenHeight)];
    self.labelDianbo.text = @"点拨";
    self.labelDianbo.font = [UIFont fontWithName:@"Arial" size:8];
    
    [self addSubview:_labelDianbo];
    
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitButton.frame = CGRectMake(CGRectGetMaxX(self.dianboButton.frame) + 80/375. *ScreenWidth, CGRectGetMinY(self.dianboButton.frame), 100/375. *ScreenWidth, 40/667. *ScreenHeight);
    
    self.submitButton.backgroundColor = [UIColor colorWithHexString:@"00c195" alpha:1.0];
    self.submitButton.layer.cornerRadius = 20.0;
 
    
    [self addSubview:self.submitButton];
    
}

@end
