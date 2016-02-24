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
    
    self.dataList = [[NSMutableArray alloc] init];
    self.labelArray = [[NSMutableArray alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated{
    if ([self.noteView shown]) {
        [self.noteView hide];
    }
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
    
    //设置显示题目的高度
    [self.headerView setHeight:[UtilityManager dynamicHeight:content]];
    
    //设置标签栏高度
    self.noteView = [[[NSBundle mainBundle] loadNibNamed:@"NoteView" owner:self options:nil] lastObject];
    CGRect noteRect = self.noteButton.frame;
    CGFloat noteHeight = 44 * self.subject0.thinkLabel.count + 1;
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
        self.think = self.subject0.thinkLabel[[number intValue]];
        if ([self.think.name isEqualToString:@"选项精析"]) {
            return;
        }

        for(Note *note in self.think.noteArray){
            NSInteger calculate = self.dataList.count - 1;
            while (calculate >= 0) {
                Label *label = [self.labelArray objectAtIndex:calculate];
                NSNumber *location = label.positionStart;
                if ([note.positionStart integerValue] >= [location integerValue]) {
                    [self messageHighlight:label.label startPosition:self.subject0.allString[[note.positionStart intValue]] endPosition:self.subject0.allString[[note.positionEnd intValue]]];
                    break;
                }
                calculate = calculate - 1;
            }
            if (calculate == -1) {
                [self messageHighlight:self.headerView.content startPosition:self.subject0.allString[[note.positionStart intValue]] endPosition:self.subject0.allString[[note.positionEnd intValue]]];
            }
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
        label.positionStart = [NSNumber numberWithInteger:[label.positionStart integerValue] + [self.subject0.answers[i] count]];
    }
    label.positionStart = [NSNumber numberWithInteger:[label.positionStart integerValue] + self.subject0.content.count];
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


- (void)noteRequest:(UITapGestureRecognizer *)recognizer{
    [self.noteView setData:self.subject0.thinkLabel];
    [self.noteView toggle];
    
}

@end