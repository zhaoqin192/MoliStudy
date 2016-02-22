//
//  SubjectViewController.m
//  MoliStudy
//
//  Created by zhaoqin on 2/18/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectTableViewCell.h"
#import "OptionTableViewCell.h"
#import "SubjectHeaderView.h"

#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH ScreenWidth
#define CELL_CONTENT_MARGIN 10.0f

@interface SubjectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) Subject *subject0;
@property (nonatomic, retain) NSArray *dataList;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) OptionTableViewCell *prototypeCell;
@property (nonatomic, strong) SubjectHeaderView *headerView;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentView) name:@"NETWORKREQUEST_SUBJECT_SUCCESS" object:nil];
    
    [NetworkManager getQuestion:@"3" viewID:@"101"];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"option"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"header"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];

    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"option"];

    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"SubjectHeaderView" owner:self options:nil] lastObject];
    
}

// 接收广播之后的回调方法，显示题目
- (void)presentView{
    NSArray *array = [[SubjectDAO sharedManager] findAll];
    self.subject0 = array[0];
    
    self.dataList = self.subject0.answers;
    
 
    [self.tableView reloadData];

    NSString *content = @"";
    for (NSString *str in self.subject0.content) {
        content = [content stringByAppendingString:str];
        content = [content stringByAppendingString:@" "];
    }
    self.headerView.content.text = content;
    [self.tableView setTableHeaderView:self.headerView];
    
    //设置显示题目的高度
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
    CGSize size = rect.size;
    CGFloat height = MAX(size.height, 60.0f);
    [self.headerView setHeight:height + CELL_CONTENT_MARGIN * 2];

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
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(tempRange.location, tempRangeOne.location-(tempRange.location+1))];
    [strAtt addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(tempRange.location, tempRangeOne.location-(tempRange.location+1))];
    
    //change font
//    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16] range:NSMakeRange(0, [strAtt length])];
    textView.attributedText = strAtt;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.subject0.answers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    OptionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"option"];
    cell.content.text = [self.dataList objectAtIndex:indexPath.row];
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
    if ([indexPath row] == 0) {
        [self messageHighlight:self.headerView.content startPosition:self.subject0.content[0] endPosition:self.subject0.content[5]];
    }
}

@end
