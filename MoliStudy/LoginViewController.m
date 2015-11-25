//
//  LoginViewController.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "LoginViewController.h"
#import "Input_OnlyText_Cell.h"
#import <NYXImagesKit/NYXImagesKit.h>
#import "Login.h"
#import "NetworkManager.h"
#import "LeftTableViewController.h"
#import "DrawerViewController.h"
#import "MainViewController.h"
#import "AccountBL.h"
#import "Account.h"

@interface LoginViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIImageView *iconUserView;
@property (strong, nonatomic) UIButton *dismissButton;
@property (strong, nonatomic) Login *myLogin;
@property (nonatomic, strong) DrawerViewController *sideViewController;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AccountBL *accountBL = [[AccountBL alloc] init];
    Account* account = [accountBL findAccount];
    self.myLogin = [[Login alloc] init];
    self.myLogin.email = account.accountName;
    self.myLogin.password = account.password;
    //    添加myTableView
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView registerNib:[UINib nibWithNibName:kCellIdentifier_Input_OnlyText_Cell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell];
        tableView.backgroundColor = LoginBackgroundColor;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    
//    self.myTableView.contentInset = UIEdgeInsetsMake(-kHigher_iOS_6_1_DIS(20), 0, 0, 0);
    self.myTableView.tableHeaderView = [self customHeaderView];
    self.myTableView.tableFooterView=[self customFooterView];
    [self showdismissButton:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self refreshIconUserImage];
    [self configureNotification];
}

- (void)didReceiveMemoryWarning{
    [self removeNotification];
}


- (void)showdismissButton:(BOOL)willShow{
    self.dismissButton.hidden = !willShow;
    if (!self.dismissButton && willShow) {
        self.dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
        [self.dismissButton setImage:[UIImage imageNamed:@"dismissBtn_Nav"] forState:UIControlStateNormal];
        [self.dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.dismissButton];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Input_OnlyText_Cell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_Cell forIndexPath:indexPath];
    cell.isForLoginVC = YES;
    __weak typeof(self) weakSelf = self;
        if (indexPath.row == 0) {
            cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
            [cell configWithPlaceholder:@" 电子邮箱/个性后缀" andValue:self.myLogin.email];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                [weakSelf.iconUserView setImage:[UIImage imageNamed:@"icon_user_monkey"]];
                weakSelf.myLogin.email = valueStr;
            };
            cell.editDidEndBlock = ^(NSString *textStr){
                [weakSelf refreshIconUserImage];
            };
        }else if (indexPath.row == 1){
            [cell configWithPlaceholder:@" 密码" andValue:self.myLogin.password];
            cell.textField.secureTextEntry = YES;
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myLogin.password = valueStr;
            };
        }
    return cell;
}

- (void)refreshIconUserImage{
//    NSString *textStr = self.myLogin.email;
//    if (textStr) {
//        User *curUser = [Login userWithGlobaykeyOrEmail:textStr];
//        if (curUser && curUser.avatar) {
//            [self.iconUserView sd_setImageWithURL:[curUser.avatar urlImageWithCodePathResizeToView:self.iconUserView] placeholderImage:[UIImage imageNamed:@"icon_user_monkey"]];
//        }
//    }
}

#pragma mark - Register Notification

- (void)configureNotification{
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_LOGIN_SUCCESS" object:nil] subscribeNext:^(id x) {
        [ProgressHUD showSuccess:@"登录成功！"];
        
        self.sideViewController = [[DrawerViewController alloc] init];
        //抽屉
        MainViewController *mainVC = [[MainViewController alloc] init];
        UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
        LeftTableViewController *leftVC = [[LeftTableViewController alloc] init];
        _sideViewController.rootViewController = mainNC;
        _sideViewController.leftViewController = leftVC;
        _sideViewController.leftViewShowWidth = 300.0/375 *kScreen_Width;
        _sideViewController.rightViewShowWidth = 300.0/375 *kScreen_Width;
        _sideViewController.needSwipeShowMenu = YES;
        [self.navigationController pushViewController:_sideViewController animated:YES];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NSNotification NETWORKREQUEST_LOGIN_ERROR_INVALID" object:nil] subscribeNext:^(id x) {
        [ProgressHUD showError:@"用户ID错误，请重新登录."];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NSNotification NETWORKREQUEST_LOGIN_ERROR_DUPLICATE" object:nil] subscribeNext:^(id x) {
        [ProgressHUD showError:@"用户名重复."];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_LOGIN_FAILURE" object:nil] subscribeNext:^(id x) {
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view Header Footer
- (UIView *)customHeaderView{
    CGFloat iconUserViewWidth;
    if (kDevice_Is_iPhone6Plus) {
        iconUserViewWidth = 100;
    }else if (kDevice_Is_iPhone6){
        iconUserViewWidth = 90;
    }else{
        iconUserViewWidth = 75;
    }
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/3)];
    
    _iconUserView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconUserViewWidth, iconUserViewWidth)];
    _iconUserView.contentMode = UIViewContentModeScaleAspectFit;
    _iconUserView.layer.masksToBounds = YES;
    _iconUserView.layer.cornerRadius = _iconUserView.frame.size.width/2;
    _iconUserView.layer.borderWidth = 2;
    _iconUserView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [headerV addSubview:_iconUserView];
    [_iconUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconUserViewWidth, iconUserViewWidth));
        make.centerX.equalTo(headerV);
        make.centerY.equalTo(headerV).offset(30);
    }];
    [_iconUserView setImage:[UIImage imageNamed:@"icon_user_monkey"]];
    return headerV;
}

- (UIView *)customFooterView{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    _loginBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"登录" andFrame:CGRectMake(kLoginPaddingLeftWidth, 20, kScreen_Width-kLoginPaddingLeftWidth*2, 45) target:self action:@selector(sendLogin)];
    [footerV addSubview:_loginBtn];
    
    RAC(self.loginBtn,enabled) = [RACSignal combineLatest:@[RACObserve(self.myLogin,email ),RACObserve(self.myLogin, password)] reduce:^id(NSString *email,NSString *password){
        return @([email length] > 0 && [password length] > 0);
    }];
    
    UIButton *cannotLoginBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:LoginButtonColor forState:UIControlStateNormal];
        [button setTitleColor:LoginButtonColor forState:UIControlStateHighlighted];
        
        [button setTitle:@"忘记密码" forState:UIControlStateNormal];
        [footerV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.right.equalTo(footerV).offset(-kPaddingLeftWidth);
            make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        }];
        button;
    });
    [cannotLoginBtn addTarget:self action:@selector(cannotLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:LoginButtonColor forState:UIControlStateNormal];
        [button setTitleColor:LoginButtonColor forState:UIControlStateHighlighted];
        
        [button setTitle:@"立即注册" forState:UIControlStateNormal];
        [footerV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.left.equalTo(footerV).offset(kPaddingLeftWidth);
            make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        }];
        button;
    });
    [registerBtn addTarget:self action:@selector(goRegisterVC:) forControlEvents:UIControlEventTouchUpInside];
    
    return footerV;
}


#pragma mark Btn Clicked
- (void)sendLogin{
    NSLog(@"btn clicked");
    [ProgressHUD show:@"Please wait..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [NetworkManager loginRequestWithUserName:self.myLogin.email withPassword:self.myLogin.password];
    });
}


- (IBAction)goRegisterVC:(id)sender {
//    RegisterViewController *vc = [[RegisterViewController alloc] init];    
//    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"goto register");
}

- (IBAction)cannotLoginBtnClicked:(id)sender {
    NSLog(@"cannot login");
}

- (void)dismissButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
