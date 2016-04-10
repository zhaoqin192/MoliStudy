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
#import "SubjectDelegate.h"

@interface SubjectViewController : UIViewController<SubjectDelegate>

//题目
@property (nonatomic, strong) Subject *subject;
//题目列表
@property (nonatomic, strong) NSArray *subjectArray;
//题目计数
@property NSInteger index;
//题目记录列表
@property (nonatomic, strong) NSMutableArray *subjectRecordArray;
//当前的记录
@property (nonatomic, strong) SubjectRecord *record;
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
//是否已经查看答案
@property BOOL isChecked;
//左右滑动手势
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end
