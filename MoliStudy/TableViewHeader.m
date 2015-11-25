//
//  TableViewHeader.m
//  
//
//  Created by 张鹏 on 15/9/1.
//
//

#import "TableViewHeader.h"

@implementation TableViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor colorWithHexString:@"f8f8ee" alpha:1.0];
        
        [self loadViews];
        
    }
    return self;
}

- (void)loadViews
{
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70/667. *ScreenHeight)];
    
    //添加一个button 用来监听点击分组，实现分组的展开关闭。
    
    self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame=CGRectMake(30/375. *ScreenWidth, 0, ScreenWidth, 70/667. *ScreenHeight);
   
    
    [self.view addSubview:_btn];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2/375. *ScreenWidth, 10/667. *ScreenHeight, 300/375. *ScreenWidth, 50/667. *ScreenHeight)];
   
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    [_btn addSubview:_titleLabel];
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 9/667. *ScreenHeight, ScreenWidth, 2/667. *ScreenHeight)];
    
    _imageView1.image = [UIImage imageNamed:@"line.png"];
    
    [_btn addSubview:_imageView1];
    
    [self addSubview:_view];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
