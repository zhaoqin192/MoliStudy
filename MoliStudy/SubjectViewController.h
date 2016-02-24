//
//  SubjectViewController.h
//  MoliStudy
//
//  Created by zhaoqin on 2/18/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionTableViewCell.h"
#import "SubjectHeaderView.h"
#import "NoteView.h"
#import "UtilityManager.h"

//#define FONT_SIZE 16.0f
//#define CELL_CONTENT_WIDTH ScreenWidth
//#define CELL_CONTENT_MARGIN 10.0f
//#define color [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]

@interface SubjectViewController : UIViewController

@property (nonatomic, strong) Subject *subject0;
@property (nonatomic, retain) NSMutableArray *dataList;
@property (nonatomic, strong) OptionTableViewCell *prototypeCell;
@property (nonatomic, strong) SubjectHeaderView *headerView;
@property (nonatomic, strong) NoteView *noteView;
@property (nonatomic, strong) ThinkLabel *think;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end
