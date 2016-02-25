//
//  CollectionViewController.m
//  HJCarouselDemo
//
//  Created by haijiao on 15/8/20.
//  Copyright (c) 2015年 olinone. All rights reserved.
//

#import "CollectionViewController.h"
#import "HJCarouselViewCell.h"
#import "HJCarouselViewLayout.h"
#import "SubjectViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCarouselViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSIndexPath *)curIndexPath {
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *curIndexPath = nil;
    NSInteger curzIndex = 0;
    for (NSIndexPath *path in indexPaths.objectEnumerator) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:path];
        if (!curIndexPath) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
            continue;
        }
        if (attributes.zIndex > curzIndex) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
        }
    }
    return curIndexPath;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSIndexPath *curIndexPath = [self curIndexPath];
//    if (indexPath.row == curIndexPath.row) {
//        return YES;
//    }
//    
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld", indexPath.row);
   // [self presentViewController:subjectViewController animated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.continueStudyButtonClickedBlock = ^{
        NSLog(@"continueStudy %zd",indexPath.row);
        SubjectViewController *subjectViewController = [[SubjectViewController alloc] initWithNibName:@"SubjectViewController" bundle:nil];
        [self.navigationController pushViewController:subjectViewController animated:YES];
    };
    cell.checkReportButtonClickedBlock = ^{
        NSLog(@"checkReportButtonClickedBlock %zd",indexPath.row);
    };

    return cell;
}


@end
