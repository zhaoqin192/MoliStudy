//
//  NewProjectTypeViewController.m
//  Coding_iOS
//
//  Created by isaced on 15/3/30.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import "NewProjectTypeViewController.h"

@interface NewProjectTypeViewController ()

@property (nonatomic, strong) NSIndexPath *checkedIndexPath;
@property (nonatomic, strong) UIView *helpView;

@end

@implementation NewProjectTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setSeparatorColor:[UIColor colorWithRGBHex:0xe5e5e5]];

}


#pragma mark UITableView

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        cell.textLabel.text = @"私有";
        
        if (self.projectType == NewProjectTypePrivate) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }else{
        cell.textLabel.text = @"公开";
        
        if (self.projectType == NewProjectTypePublic) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Checkmark
    if (self.checkedIndexPath){
        if ([self.checkedIndexPath isEqual:indexPath]) return;
        UITableViewCell *uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
        [uncheckCell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    self.checkedIndexPath = indexPath;
    
    
    // 回调
    NewProjectType type;
    
    if (indexPath.row == 0) {
        type = NewProjectTypePrivate;
    }else{
        type = NewProjectTypePublic;
    }
    
    [self.delegate newProjectType:self didSelectType:type];
    
//    [self.navigationController popViewControllerAnimated:YES];
}


@end
