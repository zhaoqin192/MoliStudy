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
#import "TextStyle.h"
#import "AnswerTableViewCell.h"
#import "TableViewHeader.h"
#import "IntroductionViewController.h"
#import "ProblemReportViewController.h"
#import "UtilityManager.h"
@interface StudyViewController ()<UITableViewDelegate, UITableViewDataSource,MZTimerLabelDelegate,AKPickerViewDataSource, AKPickerViewDelegate,TableViewHeaderDelegate>

@property(nonatomic, strong) MZTimerLabel *TimeCountLabel;
@property (nonatomic, strong) ScrollerView *TextScrollerView;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) PickerView *pickerView;

@property (nonatomic, copy) NSArray *flagArray;//存储底部标签
@property (nonatomic, assign) int questionId; //当前题号（0-4）
@property (nonatomic, strong) NSMutableArray *questionIdArray;//后台id号
@property (nonatomic, assign) int groupId; //用户选择的答案
@property (nonatomic, strong) NSMutableArray *groupIdArray;//用户选择答案数组
@property (nonatomic, copy, readonly) NSArray *ABCDarray;//ABCD数组
@property (nonatomic, copy, readonly) NSArray *answers; //正确答案数组
@property (nonatomic, copy) NSArray *noteArray; //样式数组
@property (nonatomic, copy, readonly) NSString* answer; //正确答案
@property (nonatomic, strong) NSMutableArray *tableHeadViewArray;
@property (nonatomic, assign) NSInteger currentSection;//当前选中的tableView的section
@property (nonatomic, strong) NSMutableArray *cicleButtonArray;//按钮数组
@property (nonatomic, assign) BOOL isSubmit;//是否提交
@property (nonatomic, strong) NSMutableArray *timeArray;//记录时间数组

@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _questionId = 0;
    _ABCDarray = @[@"A", @"B", @"C", @"D"];
    _isSubmit = NO;
    _timeArray = [[NSMutableArray alloc] init];
    _groupIdArray = [[NSMutableArray alloc] init];
    _questionIdArray = [[NSMutableArray alloc] init];
    [self setScrollerView];
    [self confiureNotification];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [NetworkManager getSubjects:^{
        [self loadData];
        [self loadTimeLabel];
    }];
}

- (void)loadData{
    _groupId = -1;
    _tableHeadViewArray = [[NSMutableArray alloc] init];
    _cicleButtonArray = [[NSMutableArray alloc] init];
//    ModelManager *model = [ModelManager getInstance];
//    Subject *subject = model.subjectArray[self.questionId];
    
    NSArray *array = [[SubjectDAO sharedManager] findAll];
    Subject *subject = array[self.questionId];

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
    [self resetTimeLabel];
    [self configureTableHeaderView];
    [self configureTableView];
    [self loadTabView];
    [self loadAKPicker];
}

#pragma mark timelabel

- (void)loadTimeLabel
{
    UILabel *timeLabel;
    _TimeCountLabel = [[MZTimerLabel alloc] initWithLabel:timeLabel andTimerType:MZTimerLabelTypeStopWatch];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    _TimeCountLabel.frame = CGRectMake(0,0, 75/375. *ScreenWidth,44);
    _TimeCountLabel.timeFormat = @"HH:mm:ss";
    _TimeCountLabel.textColor = [UIColor whiteColor];
    [_TimeCountLabel start];
    self.navigationItem.titleView = _TimeCountLabel;
    [_TimeCountLabel setCenterX:self.view.centerX];
}

- (void)resetTimeLabel{
    [_TimeCountLabel reset];
    [_TimeCountLabel start];
}

- (int)countTime:(NSString *)timeLabelText{
    NSString *str = [NSString stringWithFormat:@"%@",timeLabelText];
    int a = [[str substringWithRange:NSMakeRange(0, 2)] intValue];
    int b = [[str substringWithRange:NSMakeRange(3, 2)] intValue];
    int c = [[str substringWithRange:NSMakeRange(6, 2)] intValue];
    int s = a*3600 + b*60 + c*1;
    return s;
}

#pragma mark scrollview

- (void)setScrollerView
{
    if (_TextScrollerView == nil) {
        self.TextScrollerView = [[ScrollerView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth,1/2.*ScreenHeight)];
        _TextScrollerView.textLabel.text = @"";
    }
    [self.view addSubview:_TextScrollerView];
}

#pragma mark TableHeaderView

- (void)configureTableHeaderView{
    for (int i = 0 ; i < _answers.count; i++) {
        TableViewHeader *tableViewHeader = [[TableViewHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenHeight/2 -64)/_answers.count )];
        tableViewHeader.delegate = self;
        tableViewHeader.open = NO;
        tableViewHeader.section = i;
        [tableViewHeader.cicleButton addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        tableViewHeader.cicleButton.tag = i;
        tableViewHeader.titleLabel.text = _answers[i];
        [_tableHeadViewArray addObject:tableViewHeader];
        [_cicleButtonArray addObject:tableViewHeader.cicleButton];
    }
}

- (void)buttonSelect: (UIButton*)button{
    if (!_isSubmit) {
        for(UIButton* Btn in _cicleButtonArray){
            [Btn setSelected:NO];
        }
        [button setSelected:YES];
        _groupId = (int)button.tag;
    }
}

- (void)configureCicleButton{
    if ([_ABCDarray[_groupId] isEqualToString:_answer]) {
        for (UIButton *button in _cicleButtonArray) {
            if (button.tag == _groupId){
                [button setImage:[UIImage imageNamed:@"Correct"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"Correct"] forState:UIControlStateSelected];
            }
            else{
                [button setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateSelected];
            }
        }
    }
    else{
        for (UIButton *button in _cicleButtonArray) {
            if (button.tag == _groupId) {
                [button setImage:[UIImage imageNamed:@"Faulse"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"Faulse"] forState:UIControlStateSelected];
            }
            else if ([_answer isEqualToString: _ABCDarray[button.tag]]){
                [button setImage:[UIImage imageNamed:@"Correct"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"Correct"] forState:UIControlStateSelected];
            }
            else{
                [button setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateSelected];
            }
        }
    }
}

#pragma mark tableView

- (void)configureTableView
{
    NSLog(@"configure");
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, (0.5 *ScreenHeight)-64) style:UITableViewStylePlain];
    [_tableview setTop:_TextScrollerView.bottom];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc] init];
    _tableview.separatorColor = [UIColor clearColor];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewHeader * headView = self.tableHeadViewArray[indexPath.section];
    if (headView.open) {
        return (ScreenHeight/2 - 64)/_answers.count;
    }
    else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (ScreenHeight/2 -64)/_answers.count;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.tableHeadViewArray[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TableViewHeader *headView = self.tableHeadViewArray[section];
    return headView.open ? 1:0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_answers count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - HeadViewdelegate

-(void)selectedWith:(TableViewHeader *)view{
    if (_isSubmit) {
        _currentSection = -1;
        if (view.open) {
            for(int i = 0;i<[_tableHeadViewArray count];i++)
            {
                TableViewHeader *head = [_tableHeadViewArray objectAtIndex:i];
                head.open = NO;
            }
            [_tableview reloadData];
            return;
        }
        _currentSection = view.section;
        [self reset];
    }
    else{
        [self buttonSelect:view.cicleButton];
    }
}

- (void)reset
{
    for(int i = 0;i<[_tableHeadViewArray count];i++)
    {
        TableViewHeader *head = [_tableHeadViewArray objectAtIndex:i];
        if(head.section == _currentSection)
        {
            head.open = YES;
        }else {
            head.open = NO;
        }
    }
    [_tableview reloadData];
}

#pragma mark tabView

- (void)loadTabView
{
    tabView *tabView1 = [[tabView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [tabView1 setBottom:self.view.bottom];
    tabView1.backgroundColor = [UIColor colorWithHexString:@"f8f8ee" alpha:1.0];
    [self.view addSubview:tabView1];
    //点拔方法
    [tabView1.dianboButton addTarget:self action:@selector(dianboButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //提交方法

    if (_isSubmit == NO) {
        [tabView1.submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [tabView1.submitButton setTitle:@"下一题" forState:UIControlStateNormal];
        [tabView1.submitButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)submitButtonAction{
    if (_groupId == -1) {
        [ProgressHUD showError:@"请选择答案后再提交~"];
        return;
    }

    [_TimeCountLabel pause];
    int time = [self countTime:_TimeCountLabel.text];
//    ModelManager *model = [ModelManager getInstance];
//    Subject *subject = model.subjectArray[self.questionId];
    NSArray *array = [[SubjectDAO sharedManager] findAll];
    Subject *subject = array[self.questionId];
    
    [_questionIdArray addObject:subject.questionID];
//    [NetworkManager uploadSubjectSituationWithQuestionID:subject.questionID withAnswer:self.ABCDarray[_groupId] withTime:time completion:^{
//        _isSubmit = YES;
//        NSNumber *timeNumber = [NSNumber numberWithInt:time];
//        [self.timeArray addObject:timeNumber];
//        [self.groupIdArray addObject:self.ABCDarray[_groupId]];
//        [self configureCicleButton];
//        [self loadTabView];
//        [self loadAKPicker];
//    }];
//    NetworkManager uploadSubjectAnswer:subject.questionID answer:self.ABCDarray[_groupId] time:time c
    [NetworkManager uploadSubjectAnswer:subject.questionID answer:self.ABCDarray[_groupId] time:[NSNumber numberWithInt:time] completion:^{
        _isSubmit = YES;
        NSNumber *timeNumber = [NSNumber numberWithInt:time];
        [self.timeArray addObject:timeNumber];
        [self.groupIdArray addObject:self.ABCDarray[_groupId]];
        [self configureCicleButton];
        [self loadTabView];
        [self loadAKPicker];
    }];
}

- (void)nextButtonAction{
    _isSubmit = NO;
    _questionId++;
    if (_questionId > [_answers count]) {
        NSString *ids = [_questionIdArray componentsJoinedByString:@","];
//        [NetworkManager getReportWithQuestionID:id completion:^{
//            ProblemReportViewController *proReportViewController = [[ProblemReportViewController alloc] init];
//            [self.navigationController pushViewController:proReportViewController animated:YES];
//        }];
        [NetworkManager getReport:ids completion:^{
            ProblemReportViewController *proReportViewController = [[ProblemReportViewController alloc] init];
            [self.navigationController pushViewController:proReportViewController animated:YES];
 
        }];
    }
    else{
        [self loadData];
    }
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
    UILabel *textSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300/375. *ScreenWidth, 200/667. *ScreenHeight)];
//    ModelManager *model = [ModelManager getInstance];
    NSArray *model = [[SubjectDAO sharedManager] findAll];
//    Subject *subject = model.subjectArray[self.questionId];
    Subject *subject = model[self.questionId];
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

    textSignLabel.text = contentText;
//    textSignLabel.text = [UtilityManager removeHTMLTag:textSignLabel.text];
//    textSignLabel.text = [Util]
    textSignLabel.text = [UtilityManager removeHTMLTag:textSignLabel.text];
    textSignLabel.numberOfLines = 0;
    textSignLabel.backgroundColor = [UIColor whiteColor];
    
    DXPopover *popover = [DXPopover popover];
    [popover showAtView:pickerView withContentView:textSignLabel];
}

#pragma mark Notification

- (void)confiureNotification{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_REPORT_ERROR_INVALID" object:nil] subscribeNext:^(id x) {
        [ProgressHUD showError:@"用户ID错误，请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            IntroductionViewController *vc = [[IntroductionViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        });
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_REPORT_FAILURE" object:nil] subscribeNext:^(id x) {
        [ProgressHUD showError:@"网络请求失败"];
    }];

    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_UPLOAD_ERROR_INVALID" object:nil] subscribeNext:^(id x) {
        [ProgressHUD showError:@"用户ID错误，请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            IntroductionViewController *vc = [[IntroductionViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        });
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_UPLOAD_FAILURE" object:nil] subscribeNext:^(id x) {
        [ProgressHUD showError:@"网络请求失败"];
    }];
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self removeNotification];
}

@end
