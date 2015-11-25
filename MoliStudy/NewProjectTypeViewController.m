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
@property (nonatomic, strong, readonly) NSArray* yearArray;
@property (nonatomic, strong, readonly) NSArray* schoolArray;

@end

@implementation NewProjectTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _yearArray = @[@"2015", @"2016", @"2017", @"2018", @"2019"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"University" ofType:@"plist"];
    _schoolArray = [NSMutableArray arrayWithContentsOfFile:filePath];

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
    switch (self.projectType) {
        case NewProjectTypeTime:
            return [self.yearArray count];
            break;
        default:
            return [self.schoolArray count];
            break;
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSInteger row = indexPath.row;
    switch (self.projectType) {
        case NewProjectTypeTime:
            cell.textLabel.text = self.yearArray[row];
            break;
        default:
            cell.textLabel.text = self.schoolArray[row];
            break;
    }
   // cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
    NSString* result;
    switch (self.projectType) {
        case NewProjectTypeTime:
            result = self.yearArray[indexPath.row];
            [self.delegate newProjectType:self didSelectTime:result];
            break;
        case NewProjectTypeAim:
            result = self.schoolArray[indexPath.row];
            [self.delegate newProjectType:self didSelectAim:result];
            break;
        default:
            result = self.schoolArray[indexPath.row];
            [self.delegate newProjectType:self didSelectSchool:result];
            break;
    }
//    [self.navigationController popViewControllerAnimated:YES];
}


@end
