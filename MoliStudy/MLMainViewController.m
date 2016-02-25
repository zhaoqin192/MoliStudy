//
//  MLMainViewController.m
//  MoliStudy
//
//  Created by 王霄 on 16/2/25.
//  Copyright © 2016年 MoliStudy. All rights reserved.
//

#import "MLMainViewController.h"
#import "CollectionViewController.h"
#import "HJCarouselViewLayout.h"
#import "MLCardViewController.h"

@interface MLMainViewController ()

@end

@implementation MLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"card"]) {
        HJCarouselViewLayout *layout = nil;
        layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(306,439);
        CollectionViewController *vc = [[CollectionViewController alloc] initWithCollectionViewLayout:layout];
        MLCardViewController *cardVc = (MLCardViewController*)segue.destinationViewController;
        cardVc.collectionVC = vc;
    }
}

- (IBAction)BottomButtonClicked {
    NSLog(@"BottomButtonClicked");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
