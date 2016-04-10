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
    self.myTableView.rowHeight = 50;
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
    if (indexPath.section == 0){
        switch (indexPath.row) {
            case 0:{
                cell.titleLabel.text = @"用户名";
                cell.contentLabel.text = @"sun";
                break;
            }
            case 1:{
                cell.titleLabel.text = @"真实姓名";
                cell.contentLabel.text = @"孙正心";
                break;
            }
            case 2:{
                cell.titleLabel.text = @"性别";
                cell.contentLabel.text = @"男";
                break;
            }
            case 3:{
                cell.titleLabel.text = @"学校";
                cell.contentLabel.text = @"北京邮电大学";
                break;
            }
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:{
                cell.titleLabel.text = @"手机号";
                cell.contentLabel.text = @"18888888888";
                break;
            }
            case 1:{
                cell.titleLabel.text = @"QQ号码";
                cell.contentLabel.text = @"88888888";
                break;
            }
            case 2:{
                cell.titleLabel.text = @"邮箱";
                cell.contentLabel.text = @"88888888@qq.com";
                break;
            }
            case 3:{
                cell.titleLabel.text = @"个人介绍";
                cell.contentLabel.text = @"帅B";
                break;
            }
        }
    }
    return cell;
}

@end
