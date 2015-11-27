//
//  ProblemReportViewController.m
//  
//
//  Created by 张鹏 on 15/9/29.
//
//

#import "ProblemReportViewController.h"
#import "ProReportTableViewCell.h"
#import "ReportView.h"
#import "MDRadialProgressView.h"
#import "QuestionModel.h"
//#import "StudyViewController.h"
#import "ReportModel.h"
#import "ReportProgressViewController.h"
#import "CollectionViewCell.h"

@interface ProblemReportViewController ()<UITableViewDataSource, UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ReportView *reportView;
@property (nonatomic, strong) UIButton *deltaButtonDown;
@property (nonatomic, strong) UIButton *deltaButtonUp;
@property (nonatomic, strong) UICollectionView * collectionView;


@end

@implementation ProblemReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"答题报告";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStyleDone target:self action:@selector(leftButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一组" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"00c195" alpha:1.0];
    //右侧字体白色
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f8f8ee" alpha:1.0];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.deltaButtonDown.hidden = NO;
    self.deltaButtonUp.hidden = YES;
    [self loadData1];
}



- (void)loadData1{
    [self loadReportView];
    [self loadCollectionView];
    [self loadTableView];
    [self loadDeltaView];
}

- (void)loadDeltaView{
    NSLog(@"load delta");
    _deltaButtonDown = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [_deltaButtonDown setCenterX:self.view.width/2];
    [_deltaButtonDown setBottom:64+(ScreenHeight-64)*0.4];
    [_deltaButtonDown setBackgroundImage:[UIImage imageNamed:@"daosanjiao.png"] forState:UIControlStateNormal];
    [_deltaButtonDown setBackgroundImage:[UIImage imageNamed:@"daosanjiao.png"] forState:UIControlStateHighlighted];
    [_deltaButtonDown addTarget:self action:@selector(deltaButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    _deltaButtonDown.tag = 0;
    [self.view addSubview:_deltaButtonDown];
    
    _deltaButtonUp = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [_deltaButtonUp setCenterX:self.view.width/2];
    [_deltaButtonUp setBottom:ScreenHeight];
    [_deltaButtonUp setBackgroundImage:[UIImage imageNamed:@"daosanjiao.png"] forState:UIControlStateNormal];
    [_deltaButtonUp setBackgroundImage:[UIImage imageNamed:@"daosanjiao.png"] forState:UIControlStateHighlighted];
    [_deltaButtonUp addTarget:self action:@selector(deltaButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    _deltaButtonUp.tag = 1;
    _deltaButtonUp.hidden = YES;
    [self.view addSubview:_deltaButtonUp];
    
    
}

- (void)deltaButtonSelected:(UIButton*)button{
    NSLog(@"delta button tapped");
    if (button.tag == 0) {
        [UIView animateWithDuration:1 animations:^{
            [self.tableView setTop:ScreenHeight];
            self.deltaButtonDown.hidden = YES;
        } completion:^(BOOL finished) {
            self.deltaButtonUp.hidden = NO;
        }];
    }
    else{
        [UIView animateWithDuration:1 animations:^{
            [self.tableView setTop:64+(ScreenHeight-64)*0.4];
             self.deltaButtonUp.hidden = YES;
        } completion:^(BOOL finished) {
            self.deltaButtonDown.hidden = NO;
        }];
    }
}

- (void)loadCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+(ScreenHeight-64)*0.15, ScreenWidth, (ScreenHeight-64)*0.85) collectionViewLayout:flowLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"00c195" alpha:1.0];

    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)loadReportView
{
 
    NSLog(@"loadReportView");
//    self.reportView = [[ReportView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, (ScreenHeight - 64) * 0.4)];
    self.reportView = [[ReportView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, (ScreenHeight-64)*0.15)];
    [self.view addSubview:self.reportView];
    
    self.reportView.view1.progressTotal = 100;
    self.reportView.view1.progressCounter = 10;
    self.reportView.label11.text = @"test";
    self.reportView.labelScore1.text = @"test";
    self.reportView.view2.progressTotal = 100;
    self.reportView.view2.progressCounter = 20;
    self.reportView.label12.text = @"";
    self.reportView.labelScore2.text = @"";



    self.reportView.view3.progressTotal = 100;
    self.reportView.view3.progressCounter = 20;
    self.reportView.label13.text = @"";
    self.reportView.labelScore3.text = @"";


    self.reportView.view4.progressTotal = 100;
    self.reportView.view4.progressCounter = 40;
    self.reportView.label14.text = @"";
    self.reportView.labelScore4.text = @"";


    
//    [self.reportView.button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.reportView setTotalCount:15];
    [self.reportView setCountNum:25];
    [self.reportView setTimeCount:20];
}

//- (void)buttonAction
//{
//    NSLog(@"report view button action");
//    ReportProgressViewController *progressView = [[ReportProgressViewController alloc] init];
//
//    progressView.socreArray = [NSMutableArray arrayWithArray:self.allDataArray];
//    progressView.nameArray = [NSMutableArray arrayWithArray:self.nameArray];
//    
//    [self.navigationController pushViewController:progressView animated:YES];
//    
//}

- (void)loadTableView
{
//    UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64+(ScreenHeight-64)*0.4, ScreenWidth, (ScreenHeight - 64)*0.6 )];
//    [self.tableView setTop:CGRectGetMaxY(cell.frame)];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo((ScreenHeight-64)*0.6);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftButton{
    NSLog(@"left button");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要退出学习吗(⊙_⊙)？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"不退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:cancel];
    UIAlertAction *exit = [UIAlertAction actionWithTitle:@"确定退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self leftButtonAction];
    }];
    [alert addAction:exit];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)leftButtonAction
{
    NSLog(@"leftbutton");
//    LoginViewController *login = [LoginViewController shareLogin];
//    
//    DrawerViewController *sideViewController = [login sideViewController];
//    
//    MainViewController *mainVC = [MainViewController new];
//    
//    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
//    
//    sideViewController.rootViewController = mainNC;
//    
//    [sideViewController hideSideViewController:YES];
    
}

- (void)rightBarButtonItemAction
{
    
    NSLog(@"========下一组题====");
//    StudyViewController *studyVC = [[StudyViewController alloc] init];
//    [self.navigationController pushViewController:studyVC animated:YES];

    
}
#pragma mark tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuserIdentifier = @"cell";
    
    ProReportTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    
    if (cell == nil) {
        
        cell = [[ProReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
     
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

//    if ([self.correctAnswerArray[indexPath.row] isEqualToString:self.ARR[indexPath.row]]) {
//        
//        cell.imageView11.image = [UIImage imageNamed:@"Correct"];
//        
//    }else{
    
        cell.imageView11.image = [UIImage imageNamed:@"Faulse"];
//    }
    
    cell.ansWerLabel.text = @"";
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return tableView.height/5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"cell select");
//    StudyViewController *studyVC = [[StudyViewController alloc] init];
    
   // studyVC.questionId = (int)indexPath.row;
    
//    [self.navigationController pushViewController:studyVC animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    cell.pointLabel.text = @"abc";
    cell.gradeLabel.text = @"cde";
    cell.text.text = [NSString stringWithFormat:@"+10"];
    
    return cell;
}
////头部显示的内容
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
//                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
//
//    [headerView addSubview:_headerView];//头部广告栏
//    return headerView;
//}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((ScreenWidth-30)/3, (ScreenWidth-30)/3+50);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor redColor];
    NSLog(@"选择%ld",indexPath.row);
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



@end
