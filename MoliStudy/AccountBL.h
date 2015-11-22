//
//  AccountBL.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;
@class AccountDao;

@interface AccountBL : NSObject

- (void) addAccountWithPhone:(NSString *)phone withPassword:(NSString *)password withUserID:(NSString *)userID;
- (Account*) findAccount;
- (void) completeInfoWithUserName:(NSString*)userName withCurrentSchool:(NSString*)current withTargetSchool:(NSString*)target;

@end
