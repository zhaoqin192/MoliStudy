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
//    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
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
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.index = 0;

    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"option"];

    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"SubjectHeaderView" owner:self options:nil] lastObject];
    
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
    
    [self initSwipeGesture];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    if ([self.noteView shown]) {
        [self.noteView hide];
    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
}

- (void)addItemClicked:(UIBarButtonItem*)button{
    NSLog(@"addItemClicked");
}

- (void) subjectClicked:(UIBarButtonItem*)button{
    UIStoryboard *mainViewSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    MLQuestionCardCollectionViewController *questionvc = [mainViewSB instantiateViewControllerWithIdentifier:@"MLQuestionCardCollectionViewController"];
    [self.navigationController pushViewController:questionvc animated:YES];
}


- (void) initButtons{
    self.record = self.subjectRecordArray[self.index];
    if ([self.record option] == -1) {
        [UIView animateWithDuration:0.5f animations:^{
            self.answerButton.hidden = YES;
            for(NSLayoutConstraint *constraint in self.noteButton.superview.constraints){
                if (constraint.firstItem == self.noteButton && constraint.firstAttribute == NSLayoutAttributeWidth) {
                    constraint.constant = ScreenWidth / 2;
                }
            }

            [self.view layoutIfNeeded];
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self.answerButton.hidden = NO;
            for(NSLayoutConstraint *constraint in self.noteButton.superview.constraints){
                if (constraint.firstItem == self.noteButton && constraint.firstAttribute == NSLayoutAttributeWidth) {
                    constraint.constant = 0;
                }
            }
            
            [self.view layoutIfNeeded];
        }];
    }
}

- (void) initSwipeGesture{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
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
    self.subject = self.subjectArray[self.index];
    
    [self initSubjectContent];
    
    [self initButtons];
    [self clearSelectImage];
    
    if ([self.noteView shown]) {
        [self.noteView hide];
        self.isAnswerViewShow = NO;
        self.isThoughtViewShow = NO;
    }
    
    if (self.record.option != -1) {
        [self selectImage:self.record.option];
    }
    
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

- (void) initSubjectContent{
    
    [self.dataList removeObjectsInRange:NSMakeRange(0, self.dataList.count)];
    [self.thoughtNotes removeObjectsInRange:NSMakeRange(0, self.thoughtNotes.count)];
    [self.answerNotes removeObjectsInRange:NSMakeRange(0, self.answerNotes.count)];
    [self.labelArray removeObjectsInRange:NSMakeRange(0, self.labelArray.count)];
    [self.imageArray removeObjectsInRange:NSMakeRange(0, self.imageArray.count)];
    
    for(NSArray *strArray in self.subject.answers){
        NSString *tempStr = @"";
        for(NSString *str in strArray) {
            tempStr = [[tempStr stringByAppendingString:str] stringByAppendingString:@" "];
        }
        [self.dataList addObject:tempStr];
    }
    
    [self.tableView reloadData];
    
    NSString *content = @"";
    for (NSString *str in self.subject.content) {
        content = [content stringByAppendingString:str];
        content = [content stringByAppendingString:@" "];
    }
    self.headerView.content.text = content;
//    NSString *title = [@"OG-Level1 " stringByAppendingString:[NSString stringWithFormat:@"%ld/%ld", (long)self.index + 1, self.subjectArray.count]];

//    self.headerView.titleText.text = title;
    
    [self.tableView setTableHeaderView:self.headerView];
    
    
    for(ThinkLabel *thinkLabel in self.subject.thinkLabel){
        if (![thinkLabel.name isEqualToString:@"选项精析"]) {
            [self.thoughtNotes addObject:thinkLabel];
        }else{
            [self.answerNotes addObject:thinkLabel];
        }
    }
    
    //设置显示题目的高度
    [self.headerView setHeight:[UtilityManager dynamicHeight:content] + 35];
 
}

- (void) presentAnswerButton{
    [UIView animateWithDuration:0.5f animations:^{
        self.answerButton.hidden = NO;
        for(NSLayoutConstraint *constraint in self.noteButton.superview.constraints){
            if (constraint.firstItem == self.noteButton && constraint.firstAttribute == NSLayoutAttributeWidth) {
                constraint.constant = 0;
            }
        }
        
        [self.view layoutIfNeeded];
    }];
}

// 接收广播之后的回调方法，显示题目
- (void)presentView{
    self.subjectArray = [[SubjectDAO sharedManager] findAll];
    self.subject = self.subjectArray[self.index];
   
    for (int i = 0; i < self.subjectArray.count; i++) {
        SubjectRecord *record = [[SubjectRecord alloc] init];
        [self.subjectRecordArray addObject:record];
    }
    
    [self initSubjectContent];
    
    [self initButtons];

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 根据标签内容，范围高亮题目
- (void)messageHighlight:(UILabel *)textView startPosition:(NSString *)start endPosition:(NSString *)end withStyle:(NSString *) style{
    NSString *tempStr = textView.text;
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UtilityManager colorFromHexString:[Tinty unSelectFontColor]] range:NSMakeRange(0, [strAtt length])];
    
    
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


- (void)clearHighlight{
    
    for (Label *label in self.labelArray) {
        NSString *tempStr = label.label.text;
        
        NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
        
        [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [strAtt length])];
        [strAtt addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [strAtt length])];
        label.label.attributedText = strAtt;
    }
    
    NSString *tempStr = self.headerView.content.text;

    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];

    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [strAtt length])];
    [strAtt addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [strAtt length])];
    self.headerView.content.attributedText = strAtt;
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.subject.answers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OptionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"option"];
    cell.content.text = [self.dataList objectAtIndex:indexPath.row];
    
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
    
    
    return cell;
    
}

// 根据答案内容改变cell高度
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

- (void)clearSelectImage{
    for (int i = 0 ; i < self.imageArray.count; i++) {
        UIImageView *imageView = self.imageArray[i];
        NSString *imageName = [[NSString stringWithFormat:@"%d", i] stringByAppendingString:@"_default.png"];
        imageView.image = [UIImage imageNamed:imageName];
    }
}

- (void)selectImage:(NSInteger) select{
    UIImageView *imageView = self.imageArray[select];
    NSString *imageName = [[NSString stringWithFormat:@"%ld", (long)select] stringByAppendingString:@"_select.png"];
    imageView.image = [UIImage imageNamed:imageName];
}

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

- (void)answerRequest:(UITapGestureRecognizer *)recognizer{
    self.record.isChosen = YES;
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

- (void) restoreAnswerButton{
    self.answerLabel.text = @"查看答案";
    self.answerLabel.textColor = [UtilityManager colorFromHexString:@"#ffffff"];
    self.answerButton.backgroundColor = [UtilityManager colorFromHexString:[Tinty bg_orange]];
}


@end