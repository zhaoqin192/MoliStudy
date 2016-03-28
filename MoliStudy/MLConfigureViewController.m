//
//  MLConfigureViewController.m
//  MoliStudy
//
//  Created by 王霄 on 16/3/23.
//  Copyright © 2016年 MoliStudy. All rights reserved.
//

#import "MLConfigureViewController.h"
#import "IntroductionViewController.h"
#import "MLRegisterViewController.h"

@interface MLConfigureViewController ()

@end

@implementation MLConfigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [self myFootView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 6:{
            MLRegisterViewController *vc = [[UIStoryboard storyboardWithName:@"RegisterStoryBoard" bundle:nil] instantiateInitialViewController];
            vc.isForgetPassword = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
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
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:@"确定要退出登录吗" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertvc addAction:cancel];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        IntroductionViewController *vc = [[IntroductionViewController alloc] init];
        [self presentViewController:vc animated:NO completion:nil];
    }];
    [alertvc addAction:sure];
    [self presentViewController:alertvc animated:YES completion:nil];
}

@end
