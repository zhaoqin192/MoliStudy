//
//  NoteView.h
//  MoliStudy
//
//  Created by zhaoqin on 2/22/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteTableViewCell.h"

@interface NoteView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *dataList;
@property (nonatomic, strong) NoteTableViewCell *prototypeCell;
@property (nonatomic, strong) ThinkLabel *think;
@property BOOL shown;


- (void) initHelper;
- (void) show;
- (void) hide;
- (void) toggle;
- (void) setData:(NSArray *)dataList;

@end
