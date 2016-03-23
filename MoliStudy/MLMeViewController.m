//
//  MLMeViewController.m
//  MoliStudy
//
//  Created by 王霄 on 16/3/23.
//  Copyright © 2016年 MoliStudy. All rights reserved.
//

#import "MLMeViewController.h"
#import "MLMeCell.h"

@interface MLMeViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation MLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headView.backgroundColor = highBlue;
    [self configureNavagationItem];
    [self.myTableView registerNib:[UINib nibWithNibName:@"MLMeCell" bundle:nil] forCellReuseIdentifier:@"MLMeCell"];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.myTableView reloadData];
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
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
}


#pragma mark - <UITableView>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MLMeCell"];
    return cell;
}

@end
