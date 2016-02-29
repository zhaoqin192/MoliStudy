//
//  MLCardViewController.m
//  MoliStudy
//
//  Created by 王霄 on 16/2/25.
//  Copyright © 2016年 MoliStudy. All rights reserved.
//

#import "MLCardViewController.h"
#import "CollectionViewController.h"

@interface MLCardViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@end

@implementation MLCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.collectionVC];
    //self.middleView.backgroundColor = [UIColor redColor];
    [self.middleView addSubview:self.collectionVC.view];
    self.collectionVC.view.frame = self.middleView.bounds;
    //NSLog(@"%@",NSStringFromCGRect(self.middleView.frame));
    self.bottomButton.layer.cornerRadius = self.bottomButton.frame.size.height/2;
    self.bottomButton.backgroundColor = highBlue;
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
   // NSLog(@"back");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bottomButtonClicked {
    NSLog(@"bottomButtonClicked");
}

@end
