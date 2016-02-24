//
//  NoteView.m
//  MoliStudy
//
//  Created by zhaoqin on 2/22/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView


- (void) initHelper:(CGFloat) height positionY:(CGFloat)positionY{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NoteTableViewCell" bundle:nil] forCellReuseIdentifier:@"note"];
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"note"];
    
    //设置标签栏高度
    self.noteContentView = [[[NSBundle mainBundle] loadNibNamed:@"NoteContentView" owner:self options:nil] lastObject];
    [self.noteContentView setFrame:CGRectMake(0, positionY - height, ScreenWidth, height)];
    [self.noteContentView initHelper];
    self.noteButtonPositionY = positionY;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notePresent) name:@"NOTECONTENTVIEWDISAPPEAR" object:nil];
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
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:2];
    [dictionary setObject:self.think.name forKey:@"content"];
    NSString *noteText = @"";
    for(Note *note in self.think.noteArray){
        if (![note.noteContent isEqualToString:@""]) {
            noteText = note.noteContent;
            break;
        }
    }
    [dictionary setObject:noteText forKey:@"noteText"];
    
    CGFloat height = [UtilityManager dynamicHeight:noteText] + 44;
    [self.noteContentView setFrame:CGRectMake(0, self.noteButtonPositionY - height, ScreenWidth, height)];
    
    [self.noteContentView setData:dictionary];
    [self.noteContentView show];
    
    self.hidden = YES;
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
    if([self.noteContentView shown]){
        [self.noteContentView hide];
    }
    
    self.shown = NO;
    [self removeFromSuperview];
    self.hidden = NO;
}

-(void) toggle{
    if(self.shown){
        [self hide];
    }else{
        [self show];
    }
}

- (void) notePresent{
    self.hidden = NO;
}

@end
