//
//  MLConfigureViewController.m
//  MoliStudy
//
//  Created by 王霄 on 16/3/23.
//  Copyright © 2016年 MoliStudy. All rights reserved.
//

#import "MLConfigureViewController.h"

@interface MLConfigureViewController ()

@end

@implementation MLConfigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [self myFootView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd",indexPath.row);
}

- (UIView *)myFootView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.size = CGSizeMake(self.view.width - 30, 40);
    logoutButton.centerX = self.view.centerX;
    logoutButton.y = view.height - logoutButton.height;
    [view addSubview:logoutButton];
    logoutButton.backgroundColor = [UIColor redColor];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (void)logoutButtonClicked{
    NSLog(@"logout");
}

@end
