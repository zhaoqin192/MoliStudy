//
//  AnswerTableViewCell.m
//  
//
//  Created by 张鹏 on 15/8/27.
//
//

#import "AnswerTableViewCell.h"

@implementation AnswerTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.label = [[MCTopAligningLabel alloc] initWithFrame:CGRectMake(20/375. *ScreenWidth, 3/667. *ScreenHeight, 340/375. *ScreenWidth, 50/667. *ScreenHeight)];
        
        self.label.numberOfLines = 0;
        self.label.font = [UIFont fontWithName:@"HelveTica" size:14];
        
        [self.contentView addSubview:_label];
        
        self.backgroundColor = [UIColor colorWithHexString:@"f8f8ee" alpha:1.0];
    }
    
    return self;
    
}


- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
