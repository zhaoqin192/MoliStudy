//
//  MLMeViewController.m
//  MoliStudy
//
//  Created by 王霄 on 16/3/23.
//  Copyright © 2016年 MoliStudy. All rights reserved.
//

#import "MLMeViewController.h"

@interface MLMeViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation MLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headView.backgroundColor = highBlue;
    [self configureNavagationItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)closeButtonClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)configureButtonClicked {
  //  NSLog(@"configure");
}

- (void)configureNavagationItem{
    [self.navigationController.navigationBar setBarTintColor:highBlue];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
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
