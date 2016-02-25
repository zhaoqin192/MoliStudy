//
//  SubjectViewController.m
//  MoliStudy
//
//  Created by zhaoqin on 2/18/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import "SubjectViewController.h"

@interface SubjectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *noteButton;
@property (weak, nonatomic) IBOutlet UIView *answerButton;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentView) name:@"NETWORKREQUEST_SUBJECT_SUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"NOTEHIGHLIGHT" object:nil];
    
    [NetworkManager getQuestion:@"3" viewID:@"101"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"option"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"header"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];

    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"option"];

    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"SubjectHeaderView" owner:self options:nil] lastObject];
    
    UITapGestureRecognizer *noteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noteRequest:)];
    [self.noteButton addGestureRecognizer:noteTap];
    UITapGestureRecognizer *answerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(answerRequest:)];
    [self.answerButton addGestureRecognizer:answerTap];
    
    self.dataList = [[NSMutableArray alloc] init];
    self.labelArray = [[NSMutableArray alloc] init];
    self.thoughtNotes = [[NSMutableArray alloc] init];
    self.answerNotes = [[NSMutableArray alloc] init];
    
    [self initButtons];

}


- (void)viewWillDisappear:(BOOL)animated{
    if ([self.noteView shown]) {
        [self.noteView hide];
    }
}

- (void) initButtons{
    
    [UIView animateWithDuration:0.5f animations:^{
        self.answerButton.hidden = YES;
        for(NSLayoutConstraint *constraint in self.noteButton.superview.constraints){
            if (constraint.firstItem == self.noteButton && constraint.firstAttribute == NSLayoutAttributeWidth) {
                constraint.constant = ScreenWidth / 2;
            }
        }
        
        [self.view layoutIfNeeded];
    }];
    
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
    NSArray *array = [[SubjectDAO sharedManager] findAll];
    self.subject0 = array[0];
    
    for(NSArray *strArray in self.subject0.answers){
        NSString *tempStr = @"";
        for(NSString *str in strArray) {
            tempStr = [[tempStr stringByAppendingString:str] stringByAppendingString:@" "];
        }
        [self.dataList addObject:tempStr];
    }
 
    [self.tableView reloadData];

    NSString *content = @"";
    for (NSString *str in self.subject0.content) {
        content = [content stringByAppendingString:str];
        content = [content stringByAppendingString:@" "];
    }
    self.headerView.content.text = content;
    [self.tableView setTableHeaderView:self.headerView];
    
    
    for(ThinkLabel *thinkLabel in self.subject0.thinkLabel){
        if (![thinkLabel.name isEqualToString:@"选项精析"]) {
            [self.thoughtNotes addObject:thinkLabel];
        }else{
            [self.answerNotes addObject:thinkLabel];
        }
    }
    
    //设置显示题目的高度
    [self.headerView setHeight:[UtilityManager dynamicHeight:content]];

    
    for (int i = 0; i < [self.subject0.answers count]; i++) {
        NSLog(@"answer number: %lu", (unsigned long)[self.subject0.answers[i] count]);
    }
    
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
        NSDictionary* userInfo = notification.userInfo;
        NSNumber* number = (NSNumber*)userInfo[@"thinkNumber"];
        [self clearHighlight];
        ThinkLabel *think = [[ThinkLabel alloc] init];
        think = self.subject0.thinkLabel[[number intValue]];
        if ([think.name isEqualToString:@"选项精析"]) {
            return;
        }

//        for(Note *note in think.noteArray){
//            NSInteger calculate = self.dataList.count - 1;
//            while (calculate >= 0) {
//                Label *label = [self.labelArray objectAtIndex:calculate];
//                NSNumber *location = label.positionStart;
//                if ([note.positionStart integerValue] >= [location integerValue]) {
//                    [self messageHighlight:label.label startPosition:self.subject0.allString[[note.positionStart intValue]] endPosition:self.subject0.allString[[note.positionEnd intValue]]];
//                    break;
//                }
//                calculate = calculate - 1;
//            }
//            if (calculate == -1) {
//                [self messageHighlight:self.headerView.content startPosition:self.subject0.allString[[note.positionStart intValue]] endPosition:self.subject0.allString[[note.positionEnd intValue]]];
//            }
//        }
        
        for(Note *note in think.noteArray){
            NSLog(@"note number %lu", (unsigned long)think.noteArray.count);

            if ([note.positionEnd integerValue] < self.subject0.content.count) {
                [self messageHighlight:self.headerView.content startPosition:self.subject0.allString[[note.positionStart intValue]] endPosition:self.subject0.allString[[note.positionEnd intValue]]];
                continue;
            }
            
            
            NSInteger calculate = 0;
            while (calculate < self.dataList.count) {
                Label *label = [self.labelArray objectAtIndex:calculate];


//                NSLog(@"note %@", note.positionEnd);
//                NSLog(@"label %@", label.positionEnd);
                
                if ([note.positionEnd integerValue] <= [label.positionEnd integerValue]) {
                    [self messageHighlight:label.label startPosition:self.subject0.allString[[note.positionStart intValue]] endPosition:self.subject0.allString[[note.positionEnd intValue]]];
                    break;
                }
                calculate++;
//                NSLog(@"%ld", (long)calculate);
            }
//            if (calculate == self.dataList.count) {
//                [self messageHighlight:self.headerView.content startPosition:self.subject0.allString[[note.positionStart intValue]] endPosition:self.subject0.allString[[note.positionEnd intValue]]];
//            }
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 根据标签内容，范围高亮题目
- (void)messageHighlight:(UILabel *)textView startPosition:(NSString *)start endPosition:(NSString *)end{
    NSString *tempStr = textView.text;
    
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [strAtt length])];
    
    //the range between start and end
    NSRange tempRange = [tempStr rangeOfString:start];
    NSRange tempRangeOne = [tempStr rangeOfString:end];
    //change character color
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(tempRange.location, tempRangeOne.location - tempRange.location + [end length])];
    [strAtt addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(tempRange.location, tempRangeOne.location - tempRange.location + [end length])];
    
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
    
    return self.subject0.answers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OptionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"option"];
    cell.content.text = [self.dataList objectAtIndex:indexPath.row];
    
    Label *label = [[Label alloc] init];
    label.label = cell.content;
    for(int i = 0; i < indexPath.row; i++){
        label.positionEnd = [NSNumber numberWithInteger:[label.positionEnd integerValue] + [self.subject0.answers[i] count]];

    }
    
//    NSLog(@"labelPositionEnd %@", label.positionEnd);
    
    label.positionEnd = [NSNumber numberWithInteger:[label.positionEnd integerValue] + self.subject0.content.count + [self.subject0.answers[indexPath.row] count] - 1];
//    NSLog(@"label.text.length %lu", [self.subject0.answers[indexPath.row] count]);
//    NSLog(@"content %lu", (unsigned long)self.subject0.content.count);
//    NSLog(@"cellFor %@", label.positionEnd);
    [self.labelArray addObject:label];
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
    
}

- (void)noteRequest:(UITapGestureRecognizer *)recognizer{
    if (self.isAnswerViewShow) {
        [self.noteView hide];
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
    if (self.isThoughtViewShow) {
        [self.noteView hide];
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
    
}

@end