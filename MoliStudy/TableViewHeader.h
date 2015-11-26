//
//  TableViewHeader.h
//  MoliStudy
//
//  Created by 王霄 on 15/11/26.
//  Copyright © 2015年 MoliStudy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewHeader;

@protocol TableViewHeaderDelegate <NSObject>
-(void)selectedWith:(TableViewHeader *)view;
@end

@interface TableViewHeader : UIView

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) BOOL open;
@property (nonatomic, assign) id<TableViewHeaderDelegate> delegate;
@property(nonatomic, assign) NSInteger section;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cicleButton;

@end
