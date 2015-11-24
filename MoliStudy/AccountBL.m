//
//  AccountBL.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "AccountBL.h"
#import "Account.h"
#import "AccountDao.h"
#import "DAOContext.h"

@implementation AccountBL

- (void) addAccount:(Account *)account{
    AccountDao *dao = [AccountDao sharedManager];
    [dao add:account];
}

- (void) addAccountWithPhone:(NSString *)phone withPassword:(NSString *)password withUserID:(NSString *)userID{
    AccountDao *dao = [AccountDao sharedManager];
    NSManagedObjectContext *appContext = [DAOContext getInstance].appContext;
    
    Account *account = [dao findAccount];
    if (account == nil) {
        account = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:appContext];
        account.accountName = phone;
        account.password = password;
        account.userID = userID;
        [dao add:account];
    }else{
        [dao modified:account];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_LOGIN_SUCCESS" object:nil];
}

- (Account*) findAccount{
    AccountDao *dao = [AccountDao sharedManager];
    return [dao findAccount];
}

- (void)completeInfoWithUserName:(NSString *)userName withCurrentSchool:(NSString *)current withTargetSchool:(NSString *)target{
    AccountDao *dao = [AccountDao sharedManager];
    
    Account *account = [dao findAccount];
    if(account != nil) {
        account.userName = userName;
        account.currentAcademy = current;
        account.targetAcademy = target;
        [dao modified:account];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_LOGIN_SUCCESS" object:nil];
}

@end
