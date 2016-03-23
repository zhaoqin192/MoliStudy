//
//  MLRegisterViewController.m
//  MoliStudy
//
//  Created by 王霄 on 16/3/23.
//  Copyright © 2016年 MoliStudy. All rights reserved.
//

#import "MLRegisterViewController.h"

@interface MLRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) UIButton *dismissButton;
@end

@implementation MLRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showdismissButton:YES];
}

- (IBAction)registerButtonClicked {
    NSLog(@"register");
}

- (IBAction)getCodeButtonClicked {
    NSLog(@"get code");
  //  NetworkManager
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

@end
