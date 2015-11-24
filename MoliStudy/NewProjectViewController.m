//
//  NewProjectViewController.m
//  Coding_iOS
//
//  Created by isaced on 15/3/30.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import "NewProjectViewController.h"
#import "NewProjectTypeViewController.h"

@interface NewProjectViewController ()<NewProjectTypeDelegate,UITextFieldDelegate>

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
    self.submitButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.submitButtonItem;
    
    // 默认类型
    self.projectType = NewProjectTypePrivate;

}

-(void)selectProjectImage{
    NSLog(@"select");
}

-(void)submit{
    NSLog(@"submit");
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([str length] > 0) {
        self.submitButtonItem.enabled = YES;
    }else{
        self.submitButtonItem.enabled = NO;
    }
    
    return YES;
}


#pragma mark UITableView

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 类型
        NewProjectTypeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewProjectTypeVC"];
        vc.projectType = self.projectType;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark NewProjectTypeViewController Delegate

-(void)newProjectType:(NewProjectTypeViewController *)newProjectVC didSelectType:(NewProjectType)type{
    [newProjectVC.navigationController popViewControllerAnimated:YES];
    
    //
    self.projectType = type;
    
    if (self.projectType == NewProjectTypePublic) {
        self.projectTypeLabel.text = @"公开";
    }else{
        self.projectTypeLabel.text = @"私有";
    }
}


@end
