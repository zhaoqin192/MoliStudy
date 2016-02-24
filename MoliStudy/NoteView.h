//
//  NoteView.h
//  MoliStudy
//
//  Created by zhaoqin on 2/22/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteTableViewCell.h"
#import "NoteContentView.h"
#import "UtilityManager.h"

@interface NoteView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *dataList;
@property (nonatomic, strong) NoteTableViewCell *prototypeCell;
@property (nonatomic, strong) ThinkLabel *think;
@property BOOL shown;
@property (nonatomic, strong) NoteContentView *noteContentView;
@property CGFloat noteButtonPositionY;

- (void) initHelper:(CGFloat) height positionY:(CGFloat) positionY;
- (void) show;
- (void) hide;
- (void) toggle;
- (void) setData:(NSArray *)dataList;

@end
