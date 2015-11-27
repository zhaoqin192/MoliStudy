//
//  TestViewController.m
//  MoliStudy
//
//  Created by zhaoqin on 11/20/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "TestViewController.h"
#import "NetworkManager.h"
#import "AccountBL.h"
#import "Account.h"
#import "ModelManager.h"
#import "ReportBL.h"

@interface TestViewController ()
- (IBAction)registerIB:(id)sender;

- (IBAction)completeInfo:(id)sender;

- (IBAction)login:(id)sender;

- (IBAction)findAccount:(id)sender;

- (IBAction)verify:(id)sender;
- (IBAction)submitVerify:(id)sender;
- (IBAction)getIndex:(id)sender;
- (IBAction)getSubject:(id)sender;
- (IBAction)upload:(id)sender;

- (IBAction)report:(id)sender;
- (IBAction)getTrainList:(id)sender;
- (IBAction)getSpecialSub:(id)sender;
- (IBAction)localSub:(id)sender;
- (IBAction)getLocalReport:(id)sender;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerIB:(id)sender {
    [NetworkManager registerRequestWithPhone:@"18810541665" withPassword:@"123456"];
}

- (IBAction)completeInfo:(id)sender {
    [NetworkManager completeUserInfoWithUserName:@"muggins" withCurrentSchool:@"北邮" withTargetSchool:@"北邮"];
}

- (IBAction)login:(id)sender {
    [NetworkManager loginRequestWithUserName:@"18810541665" withPassword:@"123456"];
}

- (IBAction)findAccount:(id)sender {
    AccountBL *accountBL = [[AccountBL alloc] init];
    Account *account = [accountBL findAccount];
    NSLog(@"%@", account.accountName);
    NSLog(@"%@", account.password);
    NSLog(@"%@", account.userID);
    NSLog(@"%@", account.userName);
    NSLog(@"%@", account.targetAcademy);
    NSLog(@"%@", account.currentAcademy);
}

- (IBAction)verify:(id)sender {
    [NetworkManager sendVerificationCode:@"18810541665"];
}

- (IBAction)submitVerify:(id)sender {
    [NetworkManager verifyWithCode:@"8297" withPhone:@"18810541665"];
}

- (IBAction)getIndex:(id)sender {
    [NetworkManager getRecordIndex];
}

//- (IBAction)getSubject:(id)sender {
//    [NetworkManager getSubjects];
//}

- (IBAction)upload:(id)sender {
    [NetworkManager uploadSubjectSituationWithQuestionID:@"69" withAnswer:@"a" withTime:10 completion:nil];
}

- (IBAction)report:(id)sender {
    [NetworkManager getReportWithQuestionID:@"121,122,123,124,125" completion:nil];

}

- (IBAction)getTrainList:(id)sender {
    [NetworkManager requestTrainList];
}

- (IBAction)getSpecialSub:(id)sender {
    [NetworkManager requestSubjectByID:@"26"];
}

- (IBAction)localSub:(id)sender {
//    NSLog(@"%@", [ModelManager getInstance].subjectArray[0]);
//    ModelManager *modelmanager = [ModelManager getInstance];
    NSLog(@"fucyou");
}

- (IBAction)getLocalReport:(id)sender {
    NSLog(@"%@", [[ModelManager getInstance].reportArray[0] name]);
}

@end
