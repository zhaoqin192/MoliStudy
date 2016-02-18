//
//  TestViewController.m
//  MoliStudy
//
//  Created by zhaoqin on 11/20/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

- (IBAction)login:(id)sender;
- (IBAction)courseList:(id)sender;
- (IBAction)courseLabel:(id)sender;

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


- (IBAction)login:(id)sender {
    [NetworkManager login:@"18810541665" password:@"123456"];

}


- (IBAction)courseList:(id)sender {
    [NetworkManager getCourseList:@"3" mode:@"2"];

}

- (IBAction)courseLabel:(id)sender {
    [NetworkManager getQuestion:@"3" viewID:@"101"];
}
@end
