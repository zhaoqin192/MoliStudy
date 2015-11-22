//
//  AccountDao.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;

@interface AccountDao : NSObject

@property (strong, nonatomic) Account* account;

+ (AccountDao*)sharedManager;
- (void) add:(Account*)model;
- (void) modified:(Account*)model;
- (Account*)findAccount;

@end
