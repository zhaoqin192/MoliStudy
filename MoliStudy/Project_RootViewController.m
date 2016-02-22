//
//  Project_RootViewController.m
//  MYCoding
//
//  Created by 王霄 on 15/11/12.
//  Copyright © 2015年 neotel. All rights reserved.
//

#import "Project_RootViewController.h"
#import "iCarousel.h"
#import "XTSegmentControl.h"
#import "SubjectViewController.h"

@interface Project_RootViewController ()<iCarouselDataSource,iCarouselDelegate>
@property (strong, nonatomic) iCarousel *myCarousel;
@property (strong, nonatomic) XTSegmentControl *mySegmentControl;
@property (assign, nonatomic) NSInteger oldSelectedIndex;
@property (strong, nonatomic) NSArray *segmentItems;
@property (assign, nonatomic) BOOL icarouselScrollEnabled;

@end

@implementation Project_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = vcbackgroundColor;
    [self configSegmentItems];
    [self setupNavBtn];
    _oldSelectedIndex = 0;
    _myCarousel = ({
        iCarousel *icarousel = [[iCarousel alloc] init];
        icarousel.dataSource = self;
        icarousel.delegate = self;
        icarousel.decelerationRate = 1.0;
        icarousel.scrollSpeed = 1.0;
        icarousel.type = iCarouselTypeLinear;
        icarousel.pagingEnabled = YES;
        icarousel.clipsToBounds = YES;
        icarousel.bounceDistance = 0.2;
        [self.view addSubview:icarousel];
        [icarousel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(kMySegmentControl_Height, 0, 0, 0));
        }];
        icarousel;
    });
    
    __weak typeof (_myCarousel) weakCarousel = _myCarousel;
    _mySegmentControl = [[XTSegmentControl alloc] initWithFrame:CGRectMake(0,64, kScreen_Width, kMySegmentControl_Height) Items:_segmentItems selectedBlock:^(NSInteger index) {
        if (index == _oldSelectedIndex) {
            return;
        }
        [weakCarousel scrollToItemAtIndex:index animated:NO];
    }];
    [self.view addSubview:_mySegmentControl];
    //self.icarouselScrollEnabled = NO;
    // Do any additional setup after loading the view.
}

- (void)setIcarouselScrollEnabled:(BOOL)icarouselScrollEnabled{
    _myCarousel.scrollEnabled = icarouselScrollEnabled;
}

- (void)setupNavBtn{
    self.title = @"项目";
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemClicked:)] animated:NO];
    UIBarButtonItem* book = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"book"] style:UIBarButtonItemStylePlain target:self action:@selector(addItemClicked:)];
    UIBarButtonItem* star = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"star"] style:UIBarButtonItemStylePlain target:self action:@selector(subjectClicked:)];
    [self.navigationItem setRightBarButtonItems:@[book,star]];
}

- (void)searchItemClicked:(UIBarButtonItem*)button{
    NSLog(@"search");
}

- (void)addItemClicked:(UIBarButtonItem*)button{

   
    
}

- (void) subjectClicked:(UIBarButtonItem*)button{

    SubjectViewController *subjectViewController = [[SubjectViewController alloc] initWithNibName:@"SubjectViewController" bundle:nil];
    [self.navigationController pushViewController:subjectViewController animated:nil];
}

- (void)configSegmentItems{
    _segmentItems = @[@"全部项目", @"我参与的", @"我创建的"];
}

#pragma mark iCarousel M
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return _segmentItems.count;
}

- (UIView*)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    switch (index) {
        case 0:
            tempView.backgroundColor = [UIColor redColor];
            break;
        case 1:
            tempView.backgroundColor = [UIColor greenColor];
            break;
        default:
            tempView.backgroundColor = [UIColor blackColor];
            break;
    }
    return tempView;
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    [self.view endEditing:YES];
    if (_mySegmentControl) {
        float offset = carousel.scrollOffset;
        if (offset > 0) {
            [_mySegmentControl moveIndexWithProgress:offset];
        }
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    if (_mySegmentControl) {
        _mySegmentControl.currentIndex = carousel.currentItemIndex;
        _oldSelectedIndex = carousel.currentItemIndex;
    }
}


@end
