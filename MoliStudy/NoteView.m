//
//  NoteView.m
//  MoliStudy
//
//  Created by zhaoqin on 2/22/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView


- (void) initHelper{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NoteTableViewCell" bundle:nil] forCellReuseIdentifier:@"note"];
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"note"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"note"];

    self.think = [self.dataList objectAtIndex:indexPath.row];
    cell.content.text = self.think.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.think = [self.dataList objectAtIndex:indexPath.row];
   
    NSDictionary *userInfo = @{@"thinkNumber": @(indexPath.row)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTEHIGHLIGHT" object:self userInfo:userInfo];
    
}

- (void) setData:(NSArray *)dataList{
    self.dataList = dataList;
    [self.tableView reloadData];
}

-(void) show{

    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.shown = YES;
}

-(void) hide{

    self.shown = NO;
    [self removeFromSuperview];
}

-(void) toggle{
    if(self.shown){
        [self hide];
    }else{
        [self show];
    }
}

@end
