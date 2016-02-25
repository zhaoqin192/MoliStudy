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
- (IBAction)questionButtonClicked:(UIButton *)sender {
    HJCarouselViewLayout *layout = nil;
    switch (sender.tag) {
        case 100:
            NSLog(@"clicked 100");
            break;
        case 102:
            NSLog(@"clicked 102");
            break;
        case 101:
            layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.itemSize = CGSizeMake(306,439);
            CollectionViewController *vc = [[CollectionViewController alloc] initWithCollectionViewLayout:layout];
           [self.navigationController pushViewController:vc animated:YES];
            break;
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
