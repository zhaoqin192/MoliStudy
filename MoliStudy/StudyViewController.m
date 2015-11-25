//
//  StudyViewController.m
//  MoliStudy
//
//  Created by 王霄 on 15/11/25.
//  Copyright © 2015年 MoliStudy. All rights reserved.
//

#import "StudyViewController.h"
#import "DXPopover.h"
#import "MZTimerLabel.h"
#import "ScrollerView.h"
#import "tabView.h"
#import "PickerView.h"
#import "NetworkManager.h"
#import "ModelManager.h"
#import "Subject.h"
#import "ThinkLabel.h"
#import "Note.h"
#import "UtilityBL.h"
#import "TextStyle.h"

@interface StudyViewController ()<UITableViewDelegate, UITableViewDataSource,MZTimerLabelDelegate,AKPickerViewDataSource, AKPickerViewDelegate>

@property(nonatomic, strong) MZTimerLabel *TimeCountLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *textSignLabel;

@property (nonatomic, strong) ScrollerView *TextScrollerView;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) PickerView *pickerView;

@property (nonatomic, strong) NSArray *flagArray;//存储标签
@property (nonatomic, assign) int questionId;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, strong) NSArray *noteArray;
@property (nonatomic, strong, readonly) NSString* answer;
@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _flagArray = @[@"1",@"2",@"3"];
    _questionId = 0;
    [self loadTimeLabel];
    [self setScrollerView];
     [self loadTabView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [NetworkManager getSubjects:^{
        ModelManager *model = [ModelManager getInstance];
        Subject *subject = model.subjectArray[self.questionId];
        NSString *content = @"";
        for(NSString *str in subject.content){
            content = [[content stringByAppendingString:str] stringByAppendingString:@" "];
        }
        [_TextScrollerView updateScrollViewText:content AttributeString:nil];
        _answers = subject.answers;
        _answer = subject.correctAnswer;
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (ThinkLabel* label in subject.thinkLabel) {
            [tempArray addObject:label.name];
        }
        self.flagArray = tempArray;
        
        NSMutableArray *tempNoteArray = [[NSMutableArray alloc] init];
        for (ThinkLabel* label in subject.thinkLabel) {
            [tempNoteArray addObject:label.noteArray];
        }
        self.noteArray = tempNoteArray;
        
        [self setTableView];
        [self loadAKPicker];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTimeLabel
{
    _TimeCountLabel = [[MZTimerLabel alloc] initWithLabel:_timeLabel andTimerType:MZTimerLabelTypeStopWatch];
    [_timeLabel setTextAlignment:NSTextAlignmentCenter];
    _TimeCountLabel.frame = CGRectMake(0,0, 75/375. *ScreenWidth,44);
    _TimeCountLabel.timeFormat = @"HH:mm:ss";
    _TimeCountLabel.textColor = [UIColor whiteColor];
    [_TimeCountLabel start];
    self.navigationItem.titleView = _TimeCountLabel;
    [_TimeCountLabel setCenterX:self.view.centerX];
}

- (void)setScrollerView
{
    if (_TextScrollerView == nil) {
        self.TextScrollerView = [[ScrollerView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth,1/2.*ScreenHeight)];
        _TextScrollerView.textLabel.text = @"";
    }
    [self.view addSubview:_TextScrollerView];
}

- (void)setTableView
{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1/2*ScreenHeight) style:UITableViewStylePlain];
    [_table setTop:_TextScrollerView.bottom];
    _table.delegate = self;
    _table.dataSource = self;
    _table.tableFooterView = [[UITableView alloc] init];
    [self.view addSubview:_table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc]init];
}

- (void)loadTabView
{
    tabView *tabView1 = [[tabView alloc] initWithFrame:CGRectMake(0, 605/667. *ScreenHeight, ScreenWidth, 65/667. *ScreenHeight)];
    tabView1.backgroundColor = [UIColor colorWithHexString:@"f8f8ee" alpha:1.0];
    [self.view addSubview:tabView1];
    //点拔方法
    [tabView1.dianboButton addTarget:self action:@selector(dianboButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //提交方法
    //    if (self.submitSel == NO) {
    //        [tabView1.submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //    } else if (self.submitSel == YES && self.groupId != nil) {
    //        [tabView1.submitButton setTitle:@"下一题" forState:UIControlStateNormal];
    //        [tabView1.submitButton addTarget:self action:@selector(submitButtonAction1:) forControlEvents:UIControlEventTouchUpInside];
    //        self.submitSel = NO;
    //    }
}

- (void)dianboButtonAction{
    NSLog(@"dianbo");
    if (self.pickerView.hidden) {
        self.pickerView.hidden = NO;
    }
    else{
        self.pickerView.hidden = YES;
    }
    
}


#pragma mark AKPicker

- (void)loadAKPicker
{
    self.pickerView = [[PickerView alloc] initWithFrame:CGRectMake(0, 560/667. * ScreenHeight, ScreenWidth, 50/667. * ScreenHeight)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
}

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item
{
    return self.flagArray[item];
}

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    return [self.flagArray count];
}

- (void) naviArrowPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item
{
    self.textSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300/375. *ScreenWidth, 200/667. *ScreenHeight)];
    ModelManager *model = [ModelManager getInstance];
    Subject *subject = model.subjectArray[self.questionId];
    NSString *content =@"";
    for (NSString* str in subject.content) {
        content = [[content stringByAppendingString:str] stringByAppendingString:@" "];
    }
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSArray *array = self.noteArray[item];
    NSString *contentText = @"";
    NSMutableArray *textStyleArray = [[NSMutableArray alloc] init];
    for (Note* note in array) {
        contentText = [contentText stringByAppendingString:note.noteContent];
        TextStyle *textStyle = [[TextStyle alloc] init];
        int start = [note.positionStart intValue];
        int end = [note.positionEnd intValue];
        NSString *style = note.style;
        NSArray *styleArray = [style componentsSeparatedByString:@","];
        for(NSString *index in styleArray){
            if ([index hasPrefix:@"bg"]) {
                textStyle.back = textStyle.backgroundColor[index];
                textStyle.order = [textStyle.priority indexOfObject:index];
            }
            else if([index hasPrefix:@"f"]){
                textStyle.fore = textStyle.foregroundColor[index];
            }
            NSLog(@"xxxx%@",index);
        }
        int i = 0;
        int count = 0;
        for(NSString *string in subject.content){
            i++;
            int j = i - 1;
            if (i == start) {
                textStyle.start = count + j;
            }
            count += [string length];
            if (i == end) {
                textStyle.end = count - 1 + j;
                break;
            }
        }
        [textStyleArray addObject:textStyle];
    }
    
    NSArray *sortArray = [textStyleArray sortedArrayUsingSelector:@selector(compare:)];
    for(TextStyle* style in sortArray){
        if (style.fore) {
            [attributeStr addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexString:style.fore alpha:1.0] range:NSMakeRange(style.start,style.end-style.start+1)];
        }
        
        [attributeStr addAttribute:NSBackgroundColorAttributeName  value:[UIColor colorWithHexString:style.back alpha:1.0] range:NSMakeRange(style.start,style.end-style.start+1)];
    }
    [self.TextScrollerView updateScrollViewText:content AttributeString:attributeStr];

    _textSignLabel.text = contentText;
    _textSignLabel.text = [UtilityBL removeHTMLTag:_textSignLabel.text];
    _textSignLabel.numberOfLines = 0;
    _textSignLabel.backgroundColor = [UIColor whiteColor];
    
    DXPopover *popover = [DXPopover popover];
    [popover showAtView:pickerView withContentView:_textSignLabel];
}

@end
