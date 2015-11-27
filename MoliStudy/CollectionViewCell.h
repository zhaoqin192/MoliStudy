//
//  CollectionViewCell.h
//  collectionView
//
//  Created by shikee_app05 on 14-12-10.
//  Copyright (c) 2014年 shikee_app05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) MDRadialProgressView *imgView;
@property (nonatomic ,strong) UILabel *text;
@property (nonatomic ,strong) UILabel *pointLabel;
@property (nonatomic ,strong) UILabel *gradeLabel;

@end
