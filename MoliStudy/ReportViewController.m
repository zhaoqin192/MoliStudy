//
//  ReportViewController.m
//  
//
//  Created by 张鹏 on 15/7/6.
//
//

#import "ReportViewController.h"
#import "ReportTableViewCell.h"


@interface ReportViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    

NSMutableArray *titleArray;

NSMutableArray *selectedArr;//列表是否展开状态

NSMutableDictionary *dict;
    
UITableView *tableView1;
    
}

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@end

@implementation ReportViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = myColor(210, 180, 140, 1);
    
    [self loadView1];
    
    [self loadView2];
    self.title = @"成绩报告";
  
    selectedArr = [[NSMutableArray alloc] init];
    titleArray = [NSMutableArray arrayWithObjects:@"词汇", @"长难句", @"逻辑", @"技巧", nil];
    
    //tabelView
 
    tableView1 = [[UITableView alloc] init];


    tableView1.frame = CGRectMake(0, CGRectGetMaxY(self.view2.frame) + 40, ScreenWidth, ScreenHeight/3 + 32/667. *ScreenHeight);
    
    tableView1.delegate = self;
    tableView1.dataSource = self;
    
    tableView1.backgroundColor = myColor(255, 250, 240, 1);
    //去除分割线
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView1.tableFooterView = [[UITableView alloc] init];
    [self.view addSubview:tableView1];
    
}

//---------------------------------label 4. 5缺少图片
- (void)loadView1{
    
    
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/3)];
    _view1.backgroundColor = myColor(0, 192, 150, 1.0);
    [self.view addSubview:_view1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20/375. *ScreenWidth, 80/667. *ScreenHeight, 100/375. *ScreenWidth, 30/667. *ScreenHeight)];
    label1.text = @"预测分";
    label1.font = [UIFont fontWithName:@"Helvetica" size:14];
    label1.textColor = [UIColor whiteColor];
    
    [_view1 addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(150/375. *ScreenWidth, 100/667. *ScreenHeight, 200/375. *ScreenWidth, 100/667.*ScreenHeight)];
    label2.text = @"71";
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont fontWithName:@"Helvetica" size:60];

    [_view1 addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(300/375. *ScreenWidth, 180/667. *ScreenHeight, 50/375. *ScreenWidth, 30/667. *ScreenHeight)];
    label3.text = @"分";
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont fontWithName:@"Helvetica" size:14];
    
    [_view1 addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(30/375. *ScreenWidth, CGRectGetMaxY(_view1.frame) + 10, ScreenWidth/2 - 40/375. *ScreenWidth, 40/667. *ScreenHeight)];
    
    label4.text = @"2015考研英语国家线 65";
    label4.textColor = [UIColor grayColor];
    label4.font = [UIFont fontWithName:@"Helvetica" size:12];
    
    [self.view addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label4.frame) + 20/375. *ScreenWidth, CGRectGetMaxY(_view1.frame) + 10, ScreenWidth/2 - 40/375. *ScreenWidth, 40/667. *ScreenHeight)];
    
    label5.text = @"2015清华大学分数线 65";
    label5.textColor = [UIColor grayColor];
    label5.font = [UIFont fontWithName:@"Helvetica" size:12];
    
    [self.view addSubview:label5];

}

- (void)loadView2{
    
    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view1.frame) + 50 , ScreenWidth, 100/667. *ScreenHeight)];
    _view2.backgroundColor = myColor(0, 192, 150, 1.0);
    
    [self.view addSubview:_view2];
    
    UILabel *label1 = [[UILabel alloc] init];
    
    label1.frame = CGRectMake(20/375. *ScreenWidth, 5/667. *ScreenHeight, 100/375. *ScreenWidth, 20/667. *ScreenHeight);
    label1.text = @"刷题量";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont fontWithName:@"Helvetica" size:14];
    [self.view2 addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label1.frame) , CGRectGetMaxY(label1.frame) + 5/667. *ScreenHeight, 100/375. *ScreenWidth, 50/667. *ScreenHeight)];
    label2.text = @"1314";
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont fontWithName:@"Helvetica" size:40];
    [self.view2 addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame) + 5/375. *ScreenWidth, CGRectGetMaxY(label2.frame) - 20/667. *ScreenHeight, 20/375. *ScreenWidth, 20/667. *ScreenHeight)];
    label3.text = @"道";
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont fontWithName:@"Helvetica" size:14];
    [self.view2 addSubview:label3];
    
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame) + 70, CGRectGetMinY(label1.frame), 100/375. *ScreenWidth, 20/667. *ScreenHeight)];
    label4.text = @"正确率";
    label4.textColor = [UIColor whiteColor];
    label4.font = [UIFont fontWithName:@"Helvetica" size:14];
    [self.view2 addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label4.frame), CGRectGetMaxY(label4.frame) + 5/375. *ScreenHeight, 50/375. *ScreenWidth, 50/667. *ScreenHeight)];
    label5.text = @"27";
    label5.textColor = [UIColor whiteColor];
    label5.font = [UIFont fontWithName:@"Helvetica" size:40];
    
    [self.view2 addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame) + 5/375. *ScreenWidth, CGRectGetMaxY(label5.frame) - 20/667. *ScreenHeight, 50/375. *ScreenWidth, 20/667. *ScreenHeight)];
    label6.text = @"%";
    label6.textColor = [UIColor whiteColor];
    
    [self.view2 addSubview:label6];
    
    //知识点报告
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20/375. *ScreenWidth, CGRectGetMaxY(self.view2.frame) + 5/667. *ScreenHeight, 100/375. *ScreenWidth, 30/667.* ScreenHeight)];
    label.text = @"知识点报告";
    label.font = [UIFont fontWithName:@"Helvetica" size:12];
    label.textColor = [UIColor grayColor];
    
    [self.view addSubview:label];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark datdsource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *string = [NSString stringWithFormat:@"%ld", section];
    
    if ([selectedArr containsObject:string]) {
    
        return 4;
    }
    
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexStr = [NSString stringWithFormat:@"%ld",indexPath.section];
    
    
    static NSString *reuseIdentifier = @"Rcell";
    
    ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell = nil;
    
    if (cell == nil) {
        
        cell = [[ReportTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Rcell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    
    cell.contentView.backgroundColor = myColor(255, 250, 240, 1);
    
    [cell.editButton addTarget: self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.editButton setImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
    
    cell.nameLable.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.nameLable.textColor = [UIColor grayColor];
    
    cell.sliderLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.sliderLabel.textColor = [UIColor grayColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.progressView setProgress:0.5 animated:YES];

    if ([selectedArr containsObject:indexStr]){
    
        switch (indexPath.row) {
                
            case 0:{
                
                cell.nameLable.text = @"信息定位";
                cell.sliderLabel.text = @"10/100";

                break;
            }
            case 1:{
                
                cell.nameLable.text = @"陷阱排除";
                cell.sliderLabel.text = @"25/100";

                break;
            }
            case 2:{
                
                cell.nameLable.text = @"主题归纳";
                cell.sliderLabel.text = @"50/100";

                break;
                
            }
            case 3:{
                
                cell.nameLable.text = @"技巧";
                cell.sliderLabel.text = @"75/100";
                

                break;
                
            }
                
            default:
                break;
        }
        
    
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60/667. *ScreenHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40/667. *ScreenHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30/667. *ScreenHeight)];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 15, 15)];
    imageView.tag = 20000+section;
    
    NSString *string = [NSString stringWithFormat:@"%ld",section];
    if ([selectedArr containsObject:string]) {
        
        imageView.image=[UIImage imageNamed:@"buddy_header_arrow_down@2x"];
        
    }else{
        
        imageView.image=[UIImage imageNamed:@"buddy_header_arrow_right@2x"];
    }
    
    [view addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 2/375. *ScreenWidth, CGRectGetMinY(imageView.frame), 100/375. *ScreenWidth, 20/667. *ScreenHeight)];
    titleLabel.text = [titleArray objectAtIndex:section];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    [view addSubview:titleLabel];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 7/667. *ScreenHeight, ScreenWidth, 2/667. *ScreenHeight)];
    imageView1.image = [UIImage imageNamed:@"line.png"];

    [view addSubview:imageView1];
    //添加一个button 用来监听点击分组，实现分组的展开关闭。
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, ScreenWidth, 40/667. *ScreenHeight);
    btn.tag=10000+section;
    [btn addTarget:self action:@selector(buttonCick:) forControlEvents:UIControlEventTouchDown];
    [view addSubview:btn];
    
    return view;
    
}

- (void)buttonCick:(UIButton *)sender
{
    NSString *string = [NSString stringWithFormat:@"%ld",sender.tag-10000];
    
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if ([selectedArr containsObject:string])
    {
        [selectedArr removeObject:string];
    }
    else
    {
        [selectedArr addObject:string];
    }
    
    [tableView1 reloadData];
  
}

- (void)editButtonAction:(UIButton *)sender
{
    NSLog(@"-------------------come on");
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/


@end
