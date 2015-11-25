//
//  LeftTableViewController.m
//  moliStudy
//
//  Created by 张鹏 on 15/6/29.
//  Copyright © 2015年 张鹏. All rights reserved.
//

#import "LeftTableViewController.h"
#import "leftTableViewCell.h"

@interface LeftTableViewController ()

@end

@implementation LeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.tableView registerNib:[UINib nibWithNibName:@"leftTableViewCell" bundle:nil] forCellReuseIdentifier:@"leftCell"];
    
   // self.tableView.separatorStyle = NO;
   // self.automaticallyAdjustsScrollViewInsets =NO;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/5)];
//    self.tableView.tableHeaderView.backgroundColor = myColor(255, 250, 240, 1);
//    self.view.backgroundColor = myColor(255, 250, 240, 1);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else  {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    leftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.contentView.backgroundColor = myColor(255, 250, 240, 1);
    
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    cell.imageName.image = [UIImage imageNamed:@"0"];
                    cell.labelName.text = @"我的收藏";
                    break;
                }
                case 1:{
                    cell.imageName.image = [UIImage imageNamed:@"1.png"];
                    cell.labelName.text = @"成绩报告";
                    break;
                }
                case 2:{
                    cell.imageName.image = [UIImage imageNamed:@"2.png"];
                    cell.labelName.text = @"强化训练";
                    break;
                }
                case 3:{
                    cell.imageName.image = [UIImage imageNamed:@"3"];
                    cell.labelName.text = @"打卡日历";
                    break;
                }
                case 4:{
                    cell.imageName.image = [UIImage imageNamed:@"4"];
                    cell.labelName.text = @"个人中心";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    cell.imageName.image = [UIImage imageNamed:@"3"];
                    cell.labelName.text = @"个人中心";
                    break;
                }
                case 1:{
                    cell.imageName.image = [UIImage imageNamed:@"5.png"];
                    cell.labelName.text = @"研途咨讯";
                    break;
                }
            break;
        }
        default:
            break;
      }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
   return  60.0 / 667 * kScreen_Height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  0.2f;
    }else
        return  20.2f;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"Select");
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
   // headerView.backgroundColor = myColor(255, 250, 240, 1);
    return headerView;
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
