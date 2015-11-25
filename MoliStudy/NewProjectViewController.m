//
//  NewProjectViewController.m
//  Coding_iOS
//
//  Created by isaced on 15/3/30.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import "NewProjectViewController.h"
#import "NewProjectTypeViewController.h"
#import "PhoneRegisterController.h"

@interface NewProjectViewController ()<NewProjectTypeDelegate>

@property (nonatomic, assign) NewProjectType projectType;
@property (nonatomic, strong) UIBarButtonItem *submitButtonItem;

@end

@implementation NewProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善信息(1/3)";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setSeparatorColor:[UIColor colorWithRGBHex:0xe5e5e5]];

    self.submitButtonItem = [UIBarButtonItem itemWithBtnTitle:@"下一步" target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = self.submitButtonItem;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithBtnTitle:@"取消" target:self action:@selector(dismiss)];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)submit{
    PhoneRegisterController *phoneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"phoneRegitser"];
    [self.navigationController pushViewController:phoneVC animated:YES];
}


#pragma mark UITableView

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == NewProjectTypeAim) {
        // 类型
        NewProjectTypeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewProjectTypeVC"];
        vc.projectType = NewProjectTypeAim;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == NewProjectTypeSchool) {
        // 类型
        NewProjectTypeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewProjectTypeVC"];
        vc.projectType = NewProjectTypeSchool;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == NewProjectTypeTime) {
        // 类型
        NewProjectTypeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewProjectTypeVC"];
        vc.projectType = NewProjectTypeTime;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



#pragma mark NewProjectTypeViewController Delegate

-(void)newProjectType:(NewProjectTypeViewController *)newProjectVC didSelectTime:(NSString*)time{
    [newProjectVC.navigationController popViewControllerAnimated:YES];
    self.timeLabel.text = time;
}

-(void)newProjectType:(NewProjectTypeViewController *)newProjectVC didSelectAim:(NSString*)aim{
    [newProjectVC.navigationController popViewControllerAnimated:YES];
    self.aimLabel.text = aim;
}

-(void)newProjectType:(NewProjectTypeViewController *)newProjectVC didSelectSchool:(NSString *)school{
    [newProjectVC.navigationController popViewControllerAnimated:YES];
    self.schoolLabel.text = school;
}

@end
