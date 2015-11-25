//
//  HeadView.m
//  
//
//  Created by 张鹏 on 15/9/18.
//
//

#import "HeadView.h"

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addViews];
        
    }
    return self;
}

- (void)addViews
{
    
    self.button = [[UIButton alloc] initWithFrame:self.bounds];
    _button.backgroundColor = myColor(0, 192, 150, 1.0);
  //  [_button setTitle:@"73" forState:UIControlStateNormal];//设置button的title
    _button.titleLabel.font = [UIFont systemFontOfSize:60];//title字体大小
    _button.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    
    [self addSubview:_button];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30 / 375. *ScreenWidth, 30 / 667. * ScreenHeight, 100 / 375. *ScreenWidth, 30 / 667. *ScreenHeight)];
    
    [self setUpLabel:label1 text:@"预测分" textColor:[UIColor whiteColor] size:16];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(320 / 375. *ScreenWidth, 85 / 667. *ScreenHeight, 50 / 375. *ScreenWidth, 30 /667. *ScreenHeight )];
    [self setUpLabel:label2 text:@"分" textColor:[UIColor whiteColor] size:16];
    
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(40/375. *ScreenWidth, 120/667. *ScreenHeight, 50/375. *ScreenWidth, 30/667. *ScreenHeight)];
    [self setUpLabel:label3 text:@"刷题量" textColor:[UIColor whiteColor] size:14];
    
    
    _questionCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame) + 5/375. *ScreenWidth, CGRectGetMinY(label3.frame), CGRectGetWidth(label3.frame), CGRectGetHeight(label3.frame))];
    
    _questionCountLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    _questionCountLabel.textColor = [UIColor whiteColor];

    [self.button addSubview:_questionCountLabel];
    
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(240/375. *ScreenWidth, 120/667. *ScreenHeight, 50/375. *ScreenWidth, 30/667. *ScreenHeight)];
    
    [self setUpLabel:label5 text:@"正确率" textColor:[UIColor whiteColor] size:14];
    
    _correctCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame) + 5/375. *ScreenWidth, CGRectGetMinY(label5.frame), CGRectGetWidth(label5.frame), CGRectGetHeight(label5.frame))];
    _correctCountLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    _correctCountLabel.textColor = [UIColor whiteColor];
    
    [self.button addSubview:_correctCountLabel];
}

- (void)setUpLabel:(UILabel *)label text:(NSString *)text textColor:(UIColor *)color size:(CGFloat)size{
    
    label.text = text;
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Arial" size:size];
    
    [self.button addSubview:label];
    
}

//- (void)setModel:(HomeModel *)model
//{
//    _model = model;
//    
//    [_button setTitle:[NSString stringWithFormat:@"%ld",model.average]forState:UIControlStateNormal];
//    
//    _correctCountLabel.text =[[NSString stringWithFormat:@"%.2f", (CGFloat)model.correct / model.count *100] stringByAppendingString:@"%"];;
//    
//    _questionCountLabel.text = [NSString stringWithFormat:@"%ld", model.count];
//    
//}

@end
