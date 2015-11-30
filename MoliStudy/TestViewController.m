//
//  TestViewController.m
//  MoliStudy
//
//  Created by zhaoqin on 11/20/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "TestViewController.h"

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
- (IBAction)subject:(id)sender;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"NETWORKREQUEST_LOGIN_SUCCESS" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) test{
    NSLog(@"broadcast");
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
    [NetworkManager registerAccount:@"18810541665" password:@"123456"];
}

- (IBAction)completeInfo:(id)sender {
//    [NetworkManager completeUserInfoWithUserName:@"muggins" withCurrentSchool:@"北邮" withTargetSchool:@"北邮"];
    [NetworkManager completeUserInfo:@"19910541665" currentSchool:@"BUPT" targetSchool:@"BUPT"];
}

- (IBAction)login:(id)sender {
//    [NetworkManager loginRequestWithUserName:@"18810541665" withPassword:@"123456"];
    [NetworkManager login:@"18810541665" password:@"123456"];
}

- (IBAction)findAccount:(id)sender {
//    AccountBL *accountBL = [[AccountBL alloc] init];
//    Account *account = [accountBL findAccount];
    AccountDAO *dao = [[AccountDAO alloc] init];
    Account *account = dao.findAccount;

    NSLog(@"%@", account.accountName);
    NSLog(@"%@", account.password);
    NSLog(@"%@", account.userID);
    NSLog(@"%@", account.userName);
    NSLog(@"%@", account.targetAcademy);
    NSLog(@"%@", account.currentAcademy);
}

- (IBAction)verify:(id)sender {

    [NetworkManager sendVerficationCode:@"18810541665"];
}

- (IBAction)submitVerify:(id)sender {

    [NetworkManager verify:@"6262" phone:@"18810541665"];
}

- (IBAction)getIndex:(id)sender {

    [NetworkManager getRecordIndex];
}

//- (IBAction)getSubject:(id)sender {
//    [NetworkManager getSubjects];
//}

- (IBAction)upload:(id)sender {
//    [NetworkManager uploadSubjectAnswer:[NSNumber numberWithInt:69] answer:@"a" time:[NSNumber numberWithInt:10]];
}

- (IBAction)report:(id)sender {
//    [NetworkManager getReport:@"121,122,123,124,125"];

}

- (IBAction)getTrainList:(id)sender {
    [NetworkManager requestTrainList];
}

- (IBAction)getSpecialSub:(id)sender {

    [NetworkManager requestSubjectByID:[NSNumber numberWithInt:26]];
}

- (IBAction)localSub:(id)sender {
    NSArray *array = [[NSArray alloc] init];
    array = [[PracticeDAO sharedManager] findAll];
//    NSLog(@"%@", array[0]);
    for(int i = 0; i < array.count; i++){
        Practice *practice = array[i];
        NSLog(@"%@", practice.name);
        
    }

}

- (IBAction)getLocalReport:(id)sender {
//    NSLog(@"%@", [[ModelManager getInstance].reportArray[0] name]);
    NSArray *array = [[SubjectDAO sharedManager] findAll];
//    for (Subject *dic in array){
//        NSLog(@"%@", dic.content);
//    }
//    NSLog(@"%@", array[0]);
    for(int i = 0; i < array.count; i++){
        Subject *subject = array[i];
        NSLog(@"%@", subject.questionID);
    }
}

- (IBAction)subject:(id)sender {
//    [NetworkManager getSubjects];
}

@end
