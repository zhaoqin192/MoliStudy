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

#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH ScreenWidth
#define CELL_CONTENT_MARGIN 10.0f

@interface SubjectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) Subject *subject0;
@property (nonatomic, retain) NSArray *dataList;
@property (nonatomic, strong) UILabel *label;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentView) name:@"NETWORKREQUEST_SUBJECT_SUCCESS" object:nil];
    
    [NetworkManager getQuestion:@"3" viewID:@"101"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];

}

// 接收广播之后的回调方法，显示题目
- (void)presentView{
    NSArray *array = [[SubjectDAO sharedManager] findAll];
    self.subject0 = array[0];
    
    self.dataList = self.subject0.answers;
    
    [self.tableView reloadData];

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
    
    return self.subject0.answers.count + 1;
}

//根据内容，自动调节tableView高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *content = @"";
    if ([indexPath row] == 0) {
        for (NSString *str in self.subject0.content) {
            content = [content stringByAppendingString:str];
            content = [content stringByAppendingString:@" "];
        }
    }else{
        content = [self.dataList objectAtIndex:[indexPath row] - 1];
    }
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    
    CGFloat height = MAX(size.height, 30.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if ([indexPath row] == 0) {
        // 1. cell标识符，使cell能够重用
        static NSString *CELLWITHIDENTIFIER = @"subject";
        // 2. 从TableView中获取标示符为paperCell的Cell
        SubjectTableViewCell *cell = (SubjectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CELLWITHIDENTIFIER];

        // 如果 cell = nil , 则表示 tableView 中没有可用的闲置cell
        if (cell == nil) {
            // 3. 把 SubjectTableViewCell.xib 放入数组中
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SubjectTableViewCell" owner:self options:nil];
            // 获取nib中的第一个对象
            for (id oneObject in nib) {
                // 判断获取的对象是否为自定义cell
                if ([oneObject isKindOfClass:[SubjectTableViewCell class]]) {
                    // 4. 修改 cell 对象属性
                    cell = [(SubjectTableViewCell*)oneObject initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLWITHIDENTIFIER];
                }
            }
            
            //设置label，使其自动改变高度
            self.label = [[UILabel alloc] initWithFrame:CGRectZero];
            [self.label setLineBreakMode:NSLineBreakByClipping];
            [self.label setMinimumScaleFactor:FONT_SIZE];
            [self.label setNumberOfLines:0];
            [self.label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
            [self.label setTag:1];
            
            [[cell contentView] addSubview:self.label];
        }
        
        NSString *content = @"";
        for (NSString *str in self.subject0.content) {
            content = [content stringByAppendingString:str];
            content = [content stringByAppendingString:@" "];
        }

        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:content attributes:@{
                                                                                                         NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]
                                                                                                         }];
        
        CGRect rect = [attributedText boundingRectWithSize:constraint
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        CGSize size = rect.size;
        
        if (!self.label)
            self.label = (UILabel*)[cell viewWithTag:1];
        
        [self.label setText:content];
        [self.label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        static NSString *OPTIONCELL = @"option";
        
        OptionTableViewCell *cell = (OptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:OPTIONCELL];
        UILabel *answerLabel = nil;
 
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OptionTableViewCell" owner:self options:nil];
            for (id oneObject in nib){
                if ([oneObject isKindOfClass:[OptionTableViewCell class]]){
                    cell = [(OptionTableViewCell *)oneObject initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OPTIONCELL];
                }
            }
            answerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
 
            [answerLabel setLineBreakMode:NSLineBreakByClipping];
            [answerLabel setMinimumScaleFactor:FONT_SIZE];
            [answerLabel setNumberOfLines:0];
            [answerLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
            [answerLabel setTag:2];
            [[cell contentView] addSubview:answerLabel];
            
        }
        NSUInteger row = [indexPath row] - 1;

        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:self.dataList[row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        if (!answerLabel) {
            answerLabel = (UILabel*)[cell viewWithTag:2];
        }
        [answerLabel setText:self.dataList[row]];
        [answerLabel setFrame:CGRectMake(CELL_CONTENT_MARGIN * 5, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 6), MAX(size.height, 30.0f))];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0) {
        [self messageHighlight:self.label startPosition:self.subject0.content[0] endPosition:self.subject0.content[5]];
    }
}

@end
