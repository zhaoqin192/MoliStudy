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

@interface SubjectViewController : UIViewController

//题目
@property (nonatomic, strong) Subject *subject0;
//选项列表
@property (nonatomic, retain) NSMutableArray *dataList;
//“选项精析”标签内容
@property (nonatomic, retain) NSMutableArray *answerNotes;
//“解题思路”标签内容
@property (nonatomic, retain) NSMutableArray *thoughtNotes;
//答案Cell
@property (nonatomic, strong) OptionTableViewCell *prototypeCell;
//题目View
@property (nonatomic, strong) SubjectHeaderView *headerView;
//点击按钮弹出标签View
@property (nonatomic, strong) NoteView *noteView;
//选项当中的UILabel列表
@property (nonatomic, strong) NSMutableArray *labelArray;
//选项当中的UIImage列表
@property (nonatomic, strong) NSMutableArray *imageArray;
//"选项精析"View是否已显示
@property BOOL isAnswerViewShow;
//"解题思路"View是否已显示
@property BOOL isThoughtViewShow;

@end
