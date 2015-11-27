//
//  ProReportTableViewCell.m
//  
//
//  Created by 张鹏 on 15/9/29.
//
//

#import "ProReportTableViewCell.h"

@implementation ProReportTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.imageView11 = [[UIImageView alloc] initWithFrame:CGRectMake(8/375. *ScreenWidth, 23/667. *ScreenHeight, 20/375. *ScreenWidth, 20/667. *ScreenHeight)];
        
        self.imageView11.backgroundColor = [UIColor cyanColor];
        
        [self.contentView addSubview:self.imageView11];
        
        self.ansWerLabel = [[UILabel alloc] initWithFrame:CGRectMake(30/375. *ScreenWidth, 10/667. *ScreenHeight, 330/375. *ScreenWidth, 50/667. *ScreenHeight)];
        
        self.ansWerLabel.numberOfLines = 2;
        
        self.ansWerLabel.backgroundColor = [UIColor colorWithHexString:@"f8f8ee" alpha:1.0];
        
        self.ansWerLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        
        self.ansWerLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.ansWerLabel];
        
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"f8f8ee" alpha:1.0];
        
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
