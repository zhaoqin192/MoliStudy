//
//  SubjectViewController.m
//  MoliStudy
//
//  Created by zhaoqin on 2/18/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import "SubjectViewController.h"
#import "MLQuestionCardCollectionViewController.h"
@interface SubjectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *noteButton;
@property (weak, nonatomic) IBOutlet UIView *answerButton;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end

@implementation SubjectViewController

@synthesize leftSwipeGestureRecognizer, rightSwipeGestureRecognizer;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidload");
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem* book = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"book"] style:UIBarButtonItemStylePlain target:self action:@selector(subjectClicked:)];
    UIBarButtonItem* star = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"star"] style:UIBarButtonItemStylePlain target:self action:@selector(addItemClicked:)];
    [self.navigationItem setRightBarButtonItems:@[book,star]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentView) name:@"NETWORKREQUEST_SUBJECT_SUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"NOTEHIGHLIGHT" object:nil];
    
    [NetworkManager getQuestion:@"3" viewID:@"101"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"option"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"header"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UtilityManager colorFromHexString:@"#F4F4F4"];
    //选项cell
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"option"];
    //题目内容
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"SubjectHeaderView" owner:self options:nil] lastObject];
    //底部按钮
    UITapGestureRecognizer *noteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noteRequest:)];
    [self.noteButton addGestureRecognizer:noteTap];
    UITapGestureRecognizer *answerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(answerRequest:)];
    [self.answerButton addGestureRecognizer:answerTap];
    
    
    self.dataList = [[NSMutableArray alloc] init];
    self.labelArray = [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc] init];
    self.thoughtNotes = [[NSMutableArray alloc] init];
    self.answerNotes = [[NSMutableArray alloc] init];
    self.subjectRecordArray = [[NSMutableArray alloc] init];
    self.index = 0;
    self.record = [[SubjectRecord alloc] init];
    
    [self initSwipeGesture];
    [self initButtons];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
}


- (void)viewWillDisappear:(BOOL)animated{
    if ([self.noteView shown]) {
        [self.noteView hide];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//初始化做题页面左右滑动手势
- (void) initSwipeGesture{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}


// 接收广播之后的回调方法，显示题目
- (void)presentView{
    self.subjectArray = [[SubjectDAO sharedManager] findAll];
    
    for (int i = 0; i < self.subjectArray.count; i++) {
        SubjectRecord *record = [[SubjectRecord alloc] init];
        [self.subjectRecordArray addObject:record];
    }
    
    [self initSubjectContent];
    
    
}

//当左右滑动的时候更新题目和UI
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender{
    //根据当前手势动作，更改当前记录index
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.index < self.subjectArray.count - 1) {
            self.index++;
        }
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.index >0) {
            self.index--;
        }
    }

    //初始化当前所有数据
    [self initSubjectContent];
    //初始化按钮
    [self initButtons];

    
    //清楚标签图标
    [self clearSelectImage];
    
    //假如标签View显示，隐藏
    if ([self.noteView shown]) {
        [self.noteView hide];
        self.isAnswerViewShow = NO;
        self.isThoughtViewShow = NO;
    }
    
    //设置已经选择的选项
    if (self.record.option != -1) {
        [self selectImage:self.record.option];
    }
    
    //若已经查看了答案，修改按钮内容，并设置tableView不可点击
    if (self.record.isChosen) {
        [self modifiedAnaswerButton];
        self.isChecked = YES;
        self.tableView.allowsSelection = NO;
        
        [self setHeightForNoteView:self.answerNotes.count];
        [self.noteView setData:self.answerNotes];
        [self.noteView show];
        self.isAnswerViewShow = YES;
    }else{
        [self restoreAnswerButton];
        self.isChecked = NO;
        self.tableView.allowsSelection = YES;
    }
    
}


//显示题目的时候判答题和解题思路按钮
- (void) initButtons{
    
    if ([self.record option] == -1) {
        [UIView animateWithDuration:0.5f animations:^{
            self.answerButton.hidden = YES;
            for(NSLayoutConstraint *constraint in self.noteButton.superview.constraints){
                if (constraint.firstItem == self.noteButton && constraint.firstAttribute == NSLayoutAttributeWidth) {
                    constraint.constant = ScreenWidth / 2;
                    [self.view layoutIfNeeded];
                }
            }

        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self.answerButton.hidden = NO;
            for(NSLayoutConstraint *constraint in self.noteButton.superview.constraints){
                if (constraint.firstItem == self.noteButton && constraint.firstAttribute == NSLayoutAttributeWidth) {
                    constraint.constant = 0;
                    [self.view layoutIfNeeded];
                }
            }
            
        }];
    }
}

//初始化题目内容
- (void) initSubjectContent{
    
    //清除数组，以便重新添加内容
    [self.dataList removeObjectsInRange:NSMakeRange(0, self.dataList.count)];
    [self.thoughtNotes removeObjectsInRange:NSMakeRange(0, self.thoughtNotes.count)];
    [self.answerNotes removeObjectsInRange:NSMakeRange(0, self.answerNotes.count)];
    [self.labelArray removeObjectsInRange:NSMakeRange(0, self.labelArray.count)];
    [self.imageArray removeObjectsInRange:NSMakeRange(0, self.imageArray.count)];
    
    //设置当前记录
    self.record = self.subjectRecordArray[self.index];
    
    //获取当前题目所有内容
    self.subject = self.subjectArray[self.index];
    
    //添加选项内容
    for(NSArray *strArray in self.subject.answers){
        NSString *tempStr = @"";
        for(NSString *str in strArray) {
            tempStr = [[tempStr stringByAppendingString:str] stringByAppendingString:@" "];
        }
        [self.dataList addObject:tempStr];
    }
    
    //设置标题内容
    NSString *content = @"";
    for (NSString *str in self.subject.content) {
        content = [content stringByAppendingString:str];
        content = [content stringByAppendingString:@" "];
    }
    self.headerView.content.text = content;
    self.headerView.levelTitle.text = [@"OG-Level1  " stringByAppendingString:[NSString stringWithFormat:@"%ld/%lu", (long)self.index + 1, (unsigned long)self.subjectRecordArray.count]];
    [self.tableView setTableHeaderView:self.headerView];
    //设置显示题目的高度
    [self.headerView setHeight:[UtilityManager dynamicHeight:content] + 30];
    
    //设置标签内容
    for(ThinkLabel *thinkLabel in self.subject.thinkLabel){
        if (![thinkLabel.name isEqualToString:@"选项精析"]) {
            [self.thoughtNotes addObject:thinkLabel];
        }else{
            [self.answerNotes addObject:thinkLabel];
        }
    }
    
    
    
    [self.tableView reloadData];
    [self.view layoutIfNeeded];
    
}

//显示“查看答案”按钮
- (void) presentAnswerButton{
    [UIView animateWithDuration:0.5f animations:^{
        self.answerButton.hidden = NO;
        for(NSLayoutConstraint *constraint in self.noteButton.superview.constraints){
            if (constraint.firstItem == self.noteButton && constraint.firstAttribute == NSLayoutAttributeWidth) {
                constraint.constant = 0;
                [self.view layoutIfNeeded];
            }
        }
        
    }];
}


// 设置标签栏高度
- (void) setHeightForNoteView:(CGFloat) count{
    self.noteView = [[[NSBundle mainBundle] loadNibNamed:@"NoteView" owner:self options:nil] lastObject];
    CGRect noteRect = self.noteButton.frame;
    CGFloat noteHeight = 44 * count + 1;
    [self.noteView setFrame:CGRectMake(0, noteRect.origin.y - noteHeight, ScreenWidth, noteHeight)];
    [self.noteView initHelper:noteHeight positionY:noteRect.origin.y];
}

-(void) receiveTestNotification:(NSNotification*)notification
{
    if ([notification.name isEqualToString:@"NOTEHIGHLIGHT"])
    {
        
        ThinkLabel *think = (ThinkLabel*) notification.object;
        [self clearHighlight];
        if ([think.name isEqualToString:@"选项精析"]) {
            return;
        }
/** 逆序寻找Label，效率较低
        for(Note *note in think.noteArray){
            NSInteger calculate = self.dataList.count - 1;
            while (calculate >= 0) {
                Label *label = [self.labelArray objectAtIndex:calculate];
                NSNumber *location = label.positionStart;
                if ([note.positionStart integerValue] >= [location integerValue]) {
                    [self messageHighlight:label.label startPosition:self.subject.allString[[note.positionStart intValue]] endPosition:self.subject.allString[[note.positionEnd intValue]]];
                    break;
                }
                calculate = calculate - 1;
            }
            if (calculate == -1) {
                [self messageHighlight:self.headerView.content startPosition:self.subject.allString[[note.positionStart intValue]] endPosition:self.subject.allString[[note.positionEnd intValue]]];
            }
        }
**/
    
// 顺序寻找Label
        for(Note *note in think.noteArray){

            if ([note.positionEnd integerValue] < self.subject.content.count) {
                [self messageHighlight:self.headerView.content startPosition:self.subject.allString[[note.positionStart intValue]] endPosition:self.subject.allString[[note.positionEnd intValue]] withStyle:note.style];
                continue;
            }
            
            
            NSInteger calculate = 0;
            while (calculate < self.dataList.count) {
                Label *label = [self.labelArray objectAtIndex:calculate];
                
                if ([note.positionEnd integerValue] <= [label.positionEnd integerValue]) {
                    [self messageHighlight:label.label startPosition:self.subject.allString[[note.positionStart intValue]] endPosition:self.subject.allString[[note.positionEnd intValue]] withStyle:note.style];
                    
                    break;
                }
                calculate++;
            }

        }
        
    }
}

// 根据标签内容，范围高亮题目
- (void)messageHighlight:(UILabel *)textView startPosition:(NSString *)start endPosition:(NSString *)end withStyle:(NSString *) style{
    NSString *tempStr = textView.text;
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    
    if (textView != self.headerView.content) {
        [strAtt addAttribute:NSForegroundColorAttributeName value:[UtilityManager colorFromHexString:@"#979797"] range:NSMakeRange(0, [strAtt length])];
    }else{
       [strAtt addAttribute:NSForegroundColorAttributeName value:[UtilityManager colorFromHexString:[Tinty unSelectFontColor]] range:NSMakeRange(0, [strAtt length])];
    }
    
    
    //the range between start and end
    NSRange tempRange = [tempStr rangeOfString:start];
    NSRange tempRangeOne = [tempStr rangeOfString:end];
    //change character color
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UtilityManager colorFromHexString:[Tinty selectFontColor]] range:NSMakeRange(tempRange.location, tempRangeOne.location - tempRange.location + [end length])];
    [strAtt addAttribute:NSBackgroundColorAttributeName value:[UtilityManager colorFromHexString:style] range:NSMakeRange(tempRange.location, tempRangeOne.location - tempRange.location + [end length])];
    
    //change font
//    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16] range:NSMakeRange(0, [strAtt length])];
    textView.attributedText = strAtt;
    
}

//清楚所有的高亮效果
- (void)clearHighlight{
    
    for (Label *label in self.labelArray) {
        NSString *tempStr = label.label.text;
        
        NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
        
        [strAtt addAttribute:NSForegroundColorAttributeName value:[UtilityManager colorFromHexString:@"#979797"] range:NSMakeRange(0, [strAtt length])];
        [strAtt addAttribute:NSBackgroundColorAttributeName value:[UtilityManager colorFromHexString:@"#F4F4F4"] range:NSMakeRange(0, [strAtt length])];
        label.label.attributedText = strAtt;
    }
    
    NSString *tempStr = self.headerView.content.text;

    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];

    [strAtt addAttribute:NSForegroundColorAttributeName value:[UtilityManager colorFromHexString:[Tinty unSelectFontColor]] range:NSMakeRange(0, [strAtt length])];
    [strAtt addAttribute:NSBackgroundColorAttributeName value:[UtilityManager colorFromHexString:@"#F4F4F4"] range:NSMakeRange(0, [strAtt length])];
    self.headerView.content.attributedText = strAtt;
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.subject.answers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OptionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"option"];
    cell.content.text = [self.dataList objectAtIndex:indexPath.row];
    cell.content.textColor = [UtilityManager colorFromHexString:@"#979797"];
    
    NSString *imageName = [[NSString stringWithFormat:@"%ld", (long)indexPath.row] stringByAppendingString:@"_default.png"];
    cell.option.image  = [UIImage imageNamed:imageName];
    
    
    Label *label = [[Label alloc] init];
    label.label = cell.content;
    for(int i = 0; i < indexPath.row; i++){
        label.positionEnd = [NSNumber numberWithInteger:[label.positionEnd integerValue] + [self.subject.answers[i] count]];

    }
    
    label.positionEnd = [NSNumber numberWithInteger:[label.positionEnd integerValue] + self.subject.content.count + [self.subject.answers[indexPath.row] count] - 1];

    [self.labelArray addObject:label];
    [self.imageArray addObject:cell.option];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UtilityManager colorFromHexString:@"#FFFFFF"];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
    
}

// 根据答案内容改变cell（选项内容）高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OptionTableViewCell *cell = (OptionTableViewCell *)self.prototypeCell;
    cell.content.text = [self.dataList objectAtIndex:indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return 1 + size.height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self presentAnswerButton];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self clearSelectImage];
    
    [self selectImage:indexPath.row];
    
    self.record.option = indexPath.row;
}

//还原选项中的图标
- (void)clearSelectImage{
    [self.tableView layoutIfNeeded];

    for (int i = 0 ; i < self.imageArray.count; i++) {
        UIImageView *imageView = self.imageArray[i];
        NSString *imageName = [[NSString stringWithFormat:@"%d", i] stringByAppendingString:@"_default.png"];
        imageView.image = [UIImage imageNamed:imageName];
    }
}

//更改选项中的图标
- (void)selectImage:(NSInteger) select{
    
    UIImageView *imageView = self.imageArray[select];
    NSString *imageName = [[NSString stringWithFormat:@"%ld", (long)select] stringByAppendingString:@"_select.png"];
    imageView.image = [UIImage imageNamed:imageName];
}

//“解题思路”触发事件
- (void)noteRequest:(UITapGestureRecognizer *)recognizer{
    if (self.isAnswerViewShow) {
        [self.noteView hide];
        self.isAnswerViewShow = NO;
    }
    
    if ([self.noteView shown]) {
        [self.noteView hide];
        self.isThoughtViewShow = NO;
    }else{
        [self setHeightForNoteView:self.thoughtNotes.count];
        [self.noteView setData:self.thoughtNotes];
        [self.noteView show];
        self.isThoughtViewShow = YES;
    }
    
}

//“查看答案”触发事件
- (void)answerRequest:(UITapGestureRecognizer *)recognizer{
    self.record.isChosen = YES;
    self.subject.isAnswered = YES;
    [self modifiedAnaswerButton];
    
    if (self.isThoughtViewShow) {
        [self.noteView hide];
        self.isThoughtViewShow = NO;
    }
    
    if ([self.noteView shown]) {
        [self.noteView hide];
        self.isAnswerViewShow = NO;
    }else{
        [self setHeightForNoteView:self.answerNotes.count];
        [self.noteView setData:self.answerNotes];
        [self.noteView show];
        self.isAnswerViewShow = YES;
    }
    
    self.isChecked = YES;
    if (self.isChecked) {
        self.tableView.allowsSelection = NO;
    }
    
}

//点击“查看答案”之后修改按钮UI
- (void) modifiedAnaswerButton{
    self.answerLabel.text = @"选项精析";
    
    if (self.record.option == self.subject.correctAnswer) {
        UIImageView *imageView = self.imageArray[self.record.option];
        imageView.image = [UIImage imageNamed:@"right.png"];
    }else{
        UIImageView *rightOption = self.imageArray[self.subject.correctAnswer];
        rightOption.image = [UIImage imageNamed:@"right.png"];
        UIImageView *faultOption = self.imageArray[self.record.option];
        faultOption.image = [UIImage imageNamed:@"fault"];
    }
    
    self.answerLabel.textColor = [UtilityManager colorFromHexString:[Tinty bg_orange]];
    self.answerButton.backgroundColor = [UtilityManager colorFromHexString:@"#ffffff"];
}

//恢复“查看答案”按钮
- (void) restoreAnswerButton{
    self.answerLabel.text = @"查看答案";
    self.answerLabel.textColor = [UtilityManager colorFromHexString:@"#ffffff"];
    self.answerButton.backgroundColor = [UtilityManager colorFromHexString:[Tinty bg_orange]];
}

- (void)addItemClicked:(UIBarButtonItem*)button{
    NSLog(@"addItemClicked");
}

- (void) subjectClicked:(UIBarButtonItem*)button{
    UIStoryboard *mainViewSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    MLQuestionCardCollectionViewController *questionvc = [mainViewSB instantiateViewControllerWithIdentifier:@"MLQuestionCardCollectionViewController"];
    [self.navigationController pushViewController:questionvc animated:YES];
}

- (void) clickCardSuccessful:(NSNumber *)number{
    
    self.index = [number intValue];
    
    //初始化当前所有数据
    [self initSubjectContent];
    //初始化按钮
    [self initButtons];
    
    
    //清楚标签图标
    [self clearSelectImage];
    
    //假如标签View显示，隐藏
    if ([self.noteView shown]) {
        [self.noteView hide];
        self.isAnswerViewShow = NO;
        self.isThoughtViewShow = NO;
    }
    
    //设置已经选择的选项
    if (self.record.option != -1) {
        [self selectImage:self.record.option];
    }
    
    //若已经查看了答案，修改按钮内容，并设置tableView不可点击
    if (self.record.isChosen) {
        [self modifiedAnaswerButton];
        self.isChecked = YES;
        self.tableView.allowsSelection = NO;
        
        [self setHeightForNoteView:self.answerNotes.count];
        [self.noteView setData:self.answerNotes];
        [self.noteView show];
        self.isAnswerViewShow = YES;
    }else{
        [self restoreAnswerButton];
        self.isChecked = NO;
        self.tableView.allowsSelection = YES;
    }

}


@end