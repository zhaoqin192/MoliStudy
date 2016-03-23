//
//  MLLoginViewController.m
//  MoliStudy
//
//  Created by 王霄 on 16/3/23.
//  Copyright © 2016年 MoliStudy. All rights reserved.
//

#import "MLLoginViewController.h"
#import "MLMainViewController.h"

@interface MLLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation MLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNotifcation];
    [self configureTextField];
}

- (void)configureTextField{
    AccountDAO *dao = [AccountDAO sharedManager];
    if ([dao isExist]) {
        Account *account = [dao findAccount];
        self.nameTextField.text = account.accountName;
        self.passwordTextField.text = account.password;
    };
}

- (IBAction)forgetPasswordButtonClicked {
    NSLog(@"forget");
}

- (IBAction)registerButtonClicked {
    NSLog(@"register");
}


- (IBAction)loginButtonClicked {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    if (self.nameTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入账号"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.passwordTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在登录..."];
    [NetworkManager login:self.nameTextField.text password:self.passwordTextField.text];
}

- (IBAction)KeyBoardEnter {
    [self.view endEditing:YES];
    [self performSelector:@selector(loginButtonClicked) withObject:nil afterDelay:0.6f];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)dealloc{
    [self removeNotification];
}

#pragma mark -<Notifacation>
- (void)configureNotifcation{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_LOGIN_SUCCESS" object:nil] subscribeNext:^(id x) {
        [self dismiss];
        MLMainViewController *vc = [[UIStoryboard storyboardWithName:@"MainView" bundle:nil] instantiateInitialViewController];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_LOGIN_ERROR_USERNAME" object:nil] subscribeNext:^(id x) {
        [SVProgressHUD showErrorWithStatus:@"用户名未找到"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_LOGIN_ERROR_PASSWORD" object:nil] subscribeNext:^(id x) {
        [SVProgressHUD showErrorWithStatus:@"密码错误"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_LOGIN_FAILURE" object:nil] subscribeNext:^(id x) {
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
