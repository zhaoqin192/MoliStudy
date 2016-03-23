//
//  MLRegisterViewController.m
//  MoliStudy
//
//  Created by 王霄 on 16/3/23.
//  Copyright © 2016年 MoliStudy. All rights reserved.
//

#import "MLRegisterViewController.h"
#import "MLMainViewController.h"
#import "MLLoginViewController.h"

@interface MLRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation MLRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showdismissButton:YES];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self configureNotifcation];
    self.codeButton.titleLabel.font = [UIFont systemFontOfSize:13];
}

- (IBAction)loginLabelClicked{
    MLLoginViewController *vc = [[UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil] instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)registerButtonClicked {
    if(![self isValidPhoneNumber:self.phoneNumberTextField.text]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.codeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    if (self.passwordTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    [SVProgressHUD show];
    [NetworkManager verify:self.codeTextField.text phone:self.phoneNumberTextField.text];
}

- (IBAction)getCodeButtonClicked {
    [self.view endEditing:YES];
    if (![self isValidPhoneNumber:self.phoneNumberTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        return;
    }
    [NetworkManager sendVerficationCode:self.phoneNumberTextField.text];
    [self beginTimer];
}

- (void)beginTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(configureCodeButtonStatus) userInfo:nil repeats:YES];
    self.codeButton.enabled = NO;
}

- (void)configureCodeButtonStatus{
    static NSInteger time = 60;
    [self.codeButton setTitle:[NSString stringWithFormat:@"%@ %ld",@"重新发送",(long)time] forState:UIControlStateNormal];
    time = time - 1;
    if (time == 0) {
        time = 60;
        [self.timer invalidate];
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeButton.enabled = YES;
    }
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)showdismissButton:(BOOL)willShow{
    self.dismissButton.hidden = !willShow;
    if (!self.dismissButton && willShow) {
        self.dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
        [self.dismissButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [self.dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.dismissButton];
    }
}

- (void)dismissButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)KeyBoardEnter {
    [self.view endEditing:YES];
    [self performSelector:@selector(registerButtonClicked) withObject:nil afterDelay:0.6f];
}

- (void)dealloc{
    [self removeNotification];
    [self.timer invalidate];
}

#pragma mark -<VerficationCode>

- (BOOL)isValidPhoneNumber:(NSString *)text{
    if (text.length != 11) {
        return NO;
    }else if (![self isAllNum:text]){
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)isAllNum:(NSString *)text{
    unichar c;
    for (int i=0; i<text.length; i++) {
        c=[text characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

#pragma mark -<Notifacation>
- (void)configureNotifcation{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_REGISTER_SUCCESS" object:nil] subscribeNext:^(id x) {
        [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
        MLMainViewController *vc = [[UIStoryboard storyboardWithName:@"MainView" bundle:nil] instantiateInitialViewController];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_REGISTER_ERROR_INVALID" object:nil] subscribeNext:^(id x) {
        [SVProgressHUD showErrorWithStatus:@"用户名未验证"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_REGISTER_ERROR_DUPLICATE" object:nil] subscribeNext:^(id x) {
        [SVProgressHUD showErrorWithStatus:@"用户名已注册"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_REGISTER_FAILURE" object:nil] subscribeNext:^(id x) {
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_VERIFY_SUCCESS" object:nil] subscribeNext:^(id x) {
        [NetworkManager registerAccount:self.phoneNumberTextField.text password:self.passwordTextField.text];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NETWORKREQUEST_VERIFY_FAILURE" object:nil] subscribeNext:^(id x) {
        [SVProgressHUD showErrorWithStatus:@"验证码输入错误，请重新输入"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
    }];
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
