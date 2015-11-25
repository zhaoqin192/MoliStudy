//
//  PhoneRegisterController.m
//  MoliStudy
//
//  Created by 王霄 on 15/11/25.
//  Copyright © 2015年 MoliStudy. All rights reserved.
//

#import "PhoneRegisterController.h"

@interface PhoneRegisterController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againpasswordTextField;
@property (nonatomic, strong) UIBarButtonItem *submitButtonItem;

@end

@implementation PhoneRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善信息(1/3)";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setSeparatorColor:[UIColor colorWithRGBHex:0xe5e5e5]];
    
    self.submitButtonItem = [UIBarButtonItem itemWithBtnTitle:@"下一步" target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = self.submitButtonItem;
}

-(void)submit{
    NSLog(@"phoneRegitser");
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


@end
