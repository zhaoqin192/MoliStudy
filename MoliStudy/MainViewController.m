//
//  MainViewController.m
//  
//
//  Created by 张鹏 on 15/9/18.
//
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "ReportViewController.h"
#import "HeadView.h"
#import "setFootView.h"
#import "StudyViewController.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HeadView *headView;
@property (nonatomic, strong) setFootView *footView;

@property (nonatomic, strong) NSMutableArray *allDataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"00c195" alpha:1.0];
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"00c195" alpha:1.0];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftButtonAction)];
    
    self.allDataArray = [[NSMutableArray alloc] init];

    //请求数据
    [self loadData];


}


- (void)loadData
{
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    
//
//    //拿到userID 请求数据用
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *userId = [NSString stringWithFormat:@"%@",[defaults stringForKey:UserId]];
//    
//    NSLog(@"========%@", userId);
//
//    [param setObject:userId forKey:@"user_id"];
//    
//    [manager POST:shouyeUrl parameters:param success:^(AFHTTPRequestOperation * __nonnull operation, id  __nonnull responseObject) {
//        
//        HomeModel *model = [[HomeModel alloc] init];
//        
//        [model setValuesForKeysWithDictionary:responseObject];
//        
//        [_allDataArray addObject:model];
//      
//        
//         [self setHeaderView];
//        
//         [self setTableView];
//        
//         [self loadFootView1];
//
//        
//    } failure:^(AFHTTPRequestOperation * __nonnull operation, NSError * __nonnull error) {
//        
//        NSLog(@"========%@", error);
//        
//    }];
    
    [self setHeaderView];
    [self setTableView];
    [self loadFootView1];

}

- (void)loadFootView1
{
    
    self.footView = [[setFootView alloc] initWithFrame:CGRectMake(0, 400/667. *ScreenHeight, ScreenWidth, 270/667. *ScreenHeight)];
    
    [self.footView.buttonStudy addTarget:self action:@selector(studyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.footView.segMent addTarget:self action:@selector(segMentAction:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view addSubview:_footView];
    
}



- (void)segMentAction:(UISegmentedControl* )seg
{
    if (seg.selectedSegmentIndex == 0) {
        NSLog(@"index  0");
        [self loadFootView1];
        
    } else if (seg.selectedSegmentIndex == 1){
        
        //应该不一样
        NSLog(@"index  1");
        [self loadFootView1];
    
    }
    
    
}


- (void)button1Action:(UIButton *)button
{
    
    [button setBackgroundColor:[UIColor cyanColor]];
    
    
}

- (void)button2Action:(UIButton *)button
{
    
    [button setBackgroundColor:[UIColor cyanColor]];
    

}
- (void)setHeaderView
{
    NSIndexPath *indexPath;
   // HomeModel *model = _allDataArray[indexPath.row];
    
    self.headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 64/667. *ScreenHeight, ScreenWidth, 170/667. *ScreenHeight)];
    
    //self.headView.model = model;
    
    [self.headView.button addTarget:self action:@selector(reportButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.headView];
    
    
}
- (void)setTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), ScreenWidth, ScreenHeight)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    
    self.tableView.tableFooterView = [[UITableView alloc] init];
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuserIdentifier = @"cell";
    
    MainTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    
   // HomeModel *model = _allDataArray[indexPath.row];
    
    if (cell == nil) {
        
        cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
        
        cell.contentView.backgroundColor = myColor(255, 255, 224, 1.0);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
   // NSLog(@"==22222222222222======%ld", model.count);
   // cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 170/667. *ScreenHeight;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftButtonAction
{
    
//    LoginViewController *login = [LoginViewController shareLogin];
//    
//    [login left];
    
    NSLog(@"left button");
}

- (void)reportButtonAction{
   ReportViewController *reportVC = [[ReportViewController alloc] init];
   [self.navigationController pushViewController:reportVC animated:YES];
}

- (void)studyButtonAction
{
    StudyViewController *studyVC = [[StudyViewController alloc] init];
    [self.navigationController pushViewController:studyVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
