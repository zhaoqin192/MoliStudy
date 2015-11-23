//
//  NetworkManager.m
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import "NetworkManager.h"
#import "UtilityBL.h"
#import "AccountBL.h"
#import "Account.h"
#import "RecordBL.h"
#import "PracticeBL.h"
#import "Subject.h"
#import "ModelManager.h"
#import "ThinkLabel.h"
#import "Note.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDKCountryAndAreaCode.h>
#import <SMS_SDK/SMSSDK+DeprecatedMethods.h>
#import <SMS_SDK/SMSSDK+ExtexdMethods.h>

@implementation NetworkManager

static AFHTTPRequestOperationManager* sharedManager = nil;
static bool debug = YES;

+ (AFHTTPRequestOperationManager*)getInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [AFHTTPRequestOperationManager manager];
        sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    });
    return sharedManager;
}

+ (void)registerRequestWithPhone:(NSString *)phone withPassword:(NSString *)password{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:[UtilityBL encryptPassword:password] forKey:@"password"];
    [[self getInstance] POST:@"http://www.molistudy.com/frontend/IOSAPI/register" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(debug){
            NSLog(@"registerAPI——%@", responseObject);
        }
        NSDictionary *responseInfo = responseObject;
        NSString* errorCode = [responseInfo objectForKey:@"err_code"];
        if ([errorCode intValue] == 0) {
            AccountBL *accountBL = [[AccountBL alloc] init];
            [accountBL addAccountWithPhone:phone withPassword:password withUserID:[responseInfo objectForKey:@"user_id"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification NETWORKREQUEST_REGISTER_SUCCESS" object:nil];
        }else if ([errorCode intValue] == 40001){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification NETWORKREQUEST_REGISTER_ERROR_INVALID" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification NETWORKREQUEST_REGISTER_ERROR_DUPLICATE" object:nil];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_REGISTER_FAILURE" object:nil];
    }];
}

+ (void)loginRequestWithUserName:(NSString *)userName withPassword:(NSString *)password{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userName forKey:@"user_name"];
    [params setObject:[UtilityBL encryptPassword:password] forKey:@"password"];
    [[self getInstance] POST:@"http://www.molistudy.com/frontend/IOSAPI/login" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(debug) {
            NSLog(@"loginAPI——%@", responseObject);
        }
        NSDictionary *responseInfo = responseObject;
        NSString *errorCode = [responseInfo objectForKey:@"err_code"];
        if ([errorCode intValue] == 0) {
            AccountBL *accountBL = [[AccountBL alloc] init];
            [accountBL addAccountWithPhone:userName withPassword:password withUserID:[responseInfo objectForKey:@"user_id"]];
        }else if([errorCode intValue] == 40002){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification NETWORKREQUEST_LOGIN_ERROR_INVALID" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification NETWORKREQUEST_LOGIN_ERROR_DUPLICATE" object:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_LOGIN_FAILURE" object:nil];
    }];
}

+ (void)completeUserInfoWithUserName:(NSString *)userName withCurrentSchool:(NSString *)currentSchool withTargetSchool:(NSString *)targetSchool{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    AccountBL *accountBL = [[AccountBL alloc] init];
    Account *account = accountBL.findAccount;
    [params setObject:userName forKey:@"user_name"];
    [params setObject:account.userID forKey:@"user_id"];
    [params setObject:currentSchool forKey:@"current_school"];
    [params setObject:targetSchool forKey:@"target_school"];
    [[self getInstance] POST:@"http://www.molistudy.com/frontend/IOSAPI/completeInfo" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(debug) {
            NSLog(@"completeInfo——%@", responseObject);
        }
        NSDictionary *responseInfo = responseObject;
        NSString *errorCode = [responseInfo objectForKey:@"err_code"];
        if([errorCode intValue] == 0){
            [accountBL completeInfoWithUserName:userName withCurrentSchool:currentSchool withTargetSchool:targetSchool];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_INFO_SUCCESS" object:nil];
        }else if ([errorCode intValue] == 40000){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_INFO_ERROR_INVALID" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_INFO_ERROR_USERNAME" object:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_INFO_FAILURE" object:nil];

    }];
}

+ (void)getSubjects{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    AccountBL *accountBL = [[AccountBL alloc] init];
    Account *account = accountBL.findAccount;
    [params setObject:account.userID forKey:@"user_id"];
    [params setObject:@"1" forKey:@"main_course_id"];
    [params setObject:@"1" forKey:@"question_type"];
    [[self getInstance] POST:@"http://www.molistudy.com/frontend/IOSAPI/getQuestion" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(debug) {
            NSLog(@"getSubjects--%@", responseObject);
        }
        NSDictionary *responseInfo = responseObject;
        NSString *errorCode = [responseInfo objectForKey:@"err_code"];
        if([errorCode intValue] == 0){
            
            NSArray *response = [responseInfo objectForKey:@"question_info"];

            
            ModelManager *modelManager = [ModelManager getInstance];
            
            for(NSDictionary *array in response){
                
                //get Subject
                Subject *subject = [[Subject alloc] init];
                [subject initData];
                NSArray *modelarr = [array objectForKey:@"modelarr"];
                NSArray *names = [modelarr[0] objectForKey:@"name"];

                for(NSString *name in names){
                    [subject.content addObject:[UtilityBL removeHTMLTag:name]];
                }
                
                //get Answers
                NSArray *answers = [modelarr[0] objectForKey:@"answers"];
                for(NSArray *answer in answers){
                    NSString *detail = [[NSString alloc] init];
                    for(NSString *answerDetail in answer){
                        detail = [[detail stringByAppendingString:answerDetail] stringByAppendingString:@" "];
                    }
                    [subject.answers addObject:detail];
                }
                subject.correctAnswer = [modelarr[0] objectForKey:@"correct_answer"];
                NSArray *thinkLabelsIDs = [modelarr[0] objectForKey:@"think_label_id"];
                for(NSString *thinkLabelID in thinkLabelsIDs){
                    [subject.thinkLabelID addObject:thinkLabelID];
                }
                //get ThinkLabel
                NSArray *thinkLabels = [modelarr[0] objectForKey:@"think_labels"];
                NSArray *thinkLists = [array objectForKey:@"thinklabellist"];
                NSArray *thinkList = thinkLists[0];

                NSMutableArray *labelName = [[NSMutableArray alloc] init];
                for(NSDictionary *dic in thinkList){
                    [labelName addObject:[dic objectForKey:@"name"]];
                }
                for(int i = 0; i < [thinkLabels count]; i++){
                    BOOL flag = NO;
                    NSArray *thinkLabel = thinkLabels[i];
                    ThinkLabel *label = [[ThinkLabel alloc] init];
                    [label initData];
                    for(NSDictionary *noteDictionary in thinkLabel){
                        if([[noteDictionary objectForKey:@"think_label_type_id"] intValue] == 0){
                            flag = YES;
                            break;
                        }
                        Note *note = [[Note alloc] init];
                        note.positionStart = [noteDictionary objectForKey:@"position_start"];
                        note.positionEnd = [noteDictionary objectForKey:@"position_end"];
                        note.style = [noteDictionary objectForKey:@"style"];
                        note.noteContent = [UtilityBL removeHTMLTag:[noteDictionary objectForKey:@"note"]];
                        [[label noteArray] addObject:note];
                    }
                    if(!flag){
                        NSDictionary *think = thinkList[i];
                        label.name = [think objectForKey:@"name"];
                        [subject.thinkLabel addObject:label];
                    }
                }
                [modelManager.subjectArray addObject:subject];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SUBJECT_SUCCESS" object:nil];
            }
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SUBJECT_ERROR_INVALID" object:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SUBJECT_FAILURE" object:nil];
    }];
}

+ (void)uploadSubjectSituationWithQuestionID:(NSString *)questionID withAnswer:(NSString *)answer withTime:(int)time{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    AccountBL *accountBL = [[AccountBL alloc] init];
    Account *account = accountBL.findAccount;
    [params setObject:account.userID forKey:@"user_id"];
    [params setObject:questionID forKey:@"question_id"];
    [params setObject:answer forKey:@"choose_answer"];
    [params setObject:[NSString stringWithFormat:@"%d", time] forKey:@"study_time"];
    [[self getInstance] POST:@"http://www.molistudy.com/frontend/IOSAPI/saveLog" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(debug) {
            NSLog(@"uploadSubjectAPI——%@", responseObject);
        }
        NSDictionary *responseInfo = responseObject;
        NSString *errorCode = [responseInfo objectForKey:@"err_code"];
        if([errorCode intValue] == 0){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_UPLOAD_SUCCESS" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_UPLOAD_ERROR_INVALID" object:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_UPLOAD_FAILURE" object:nil];
    }];
}

+ (void)getReportWithQuestionID:(NSString *)questionID{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    AccountBL *accountBL = [[AccountBL alloc] init];
    Account *account = accountBL.findAccount;
    [params setObject:account.userID forKey:@"user_id"];
    [params setObject:questionID forKey:@"question_id"];
    [[self getInstance] POST:@"http://www.molistudy.com/frontend/IOSAPI/getReport" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(debug) {
            NSLog(@"getReportAPI---%@", responseObject);
        }
        NSDictionary *responseInfo = responseObject;
        NSString *errorCode = [responseInfo objectForKey:@"err_code"];
        if([errorCode intValue] == 0){
            
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_REPORT_ERROR_INVALID" object:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_REPORT_FAILURE" object:nil];
    }];
}

+ (void)getRecordIndex{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    AccountBL *accountBL = [[AccountBL alloc] init];
    Account *account = accountBL.findAccount;
    [params setObject:account.userID forKey:@"user_id"];
    [params setObject:@"1" forKey:@"main_course_id"];
    [[self getInstance] POST:@"http://www.molistudy.com/frontend/IOSAPI/index" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(debug) {
            NSLog(@"RecordIndexAPI---%@", responseObject);
        }
        NSDictionary *responseInfo = responseObject;
        NSString *errorCode = [responseInfo objectForKey:@"err_code"];
        if([errorCode intValue] == 0){
            NSDictionary *indexInfo = [responseInfo objectForKey:@"index_info"];
            RecordBL *recordBL = [[RecordBL alloc] init];
            [recordBL addWithForecast:[indexInfo objectForKey:@"forecast"] withTotal:[indexInfo objectForKey:@"total"] withCorrect:[indexInfo objectForKey:@"correct"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_RECORD_SUCCESS" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_REPORT_ERROR_INVALID" object:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_REPORT_FAILURE" object:nil];
    }];
}

+ (void)requestTrainList{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    AccountBL *accountBL = [[AccountBL alloc] init];
    Account *account = accountBL.findAccount;
    [params setObject:account.userID forKey:@"user_id"];
    [params setObject:@"1" forKey:@"main_course_id"];
    [[self getInstance] POST:@"http://www.molistudy.com/frontend/IOSAPI/knowledgeTrain" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(debug) {
            NSLog(@"TrainList---%@", responseObject);
        }
        NSDictionary *responseInfo = responseObject;
        NSString *errorCode = [responseInfo objectForKey:@"err_code"];
        if([errorCode intValue] == 0){
            NSArray *trains = [responseInfo objectForKey:@"know_info"];
            PracticeBL *practiceBL = [[PracticeBL alloc] init];
            [practiceBL updatePracticeList:trains];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_TRAIN_ERROR_INVALID" object:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_TRAIN_FAILURE" object:nil];
    }];
}

+ (void)requestSubjectByID:(NSString *)knowledgeID{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    AccountBL *accountBL = [[AccountBL alloc] init];
    Account *account = accountBL.findAccount;
    [params setObject:account.userID forKey:@"user_id"];
    [params setObject:knowledgeID forKey:@"knowledge_id"];
    [[self getInstance] POST:@"http://www.molistudy.com/frontend/IOSAPI/getQuesByKnowId" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(debug) {
            NSLog(@"requestSubjectByID---%@", responseObject);
        }
        NSDictionary *responseInfo = responseObject;
        NSString *errorCode = [responseInfo objectForKey:@"err_code"];
        if([errorCode intValue] == 0){
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SUBJECTBYID_SUCCESS" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SUBJECTBYID_ERROR_INVALID" object:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SUBJECTBYID_FAILURE" object:nil];
    }];
}

+ (void)sendVerificationCode:(NSString *)phone{
    NSString* str = [@"86" stringByReplacingOccurrencesOfString:@"+" withString:@""];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phone
                                   zone:str
                       customIdentifier:nil
                                 result:^(NSError *error){
         if (!error)
         {
             if(debug){
                 NSLog(@"验证码发送成功");
             }
             [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SENDCODE_SUCCESS" object:nil];
         }else{
             if(debug) {
                 NSLog(@"验证码发送失败");
             }
             [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_SENDCODE_FAILURE" object:nil];
         }
     }];
}

+ (void)verifyWithCode:(NSString *)code withPhone:(NSString *)phone{
    NSString* str = [@"86" stringByReplacingOccurrencesOfString:@"+" withString:@""];
    [SMSSDK commitVerificationCode:code phoneNumber:phone zone:str result:^(NSError *error) {
        if (!error) {
            if(debug) {
                NSLog(@"验证成功");
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_VERIFY_SUCCESS" object:nil];
        }else{
            if(debug){
                NSLog(@"验证失败");
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREQUEST_VERIFY_FAILURE" object:nil];
        }
    }];

}



@end
