//
//  NetworkManager.h
//  MoliStudy1
//
//  Created by zhaoqin on 11/17/15.
//  Copyright © 2015 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

/**
 *  Singleton AFHTTPRequestOperationManager
 *
 *  @return AFHTTPRequestOperationManager
 */
+ (AFHTTPRequestOperationManager *)getInstance;

/**
 *  registerAPI
 *
 *  @param phone
 *  @param password
 *
 *  success: NSNotification NETWORKREQUEST_REGISTER_SUCCESS
 *  error: a.NSNotification NETWORKREQUEST_REGISTER_ERROR_INVALID   用户名未验证
 *         b.NSNotification NETWORKREQUEST_REGISTER_ERROR_DUPLICATE 用户名已注册
 *         c.NSNotification NETWORKREQUEST_REGISTER_FAILURE         网络请求失败
 */
+ (void)registerRequestWithPhone:(NSString *)phone withPassword:(NSString *)password;

/**
 *  loginAPI
 *
 *  @param userName\phone\email
 *  @param password
 *
 *  success: NSNotification NETWORKREQUEST_LOGIN_SUCCESS
 *  error: a.NSNotification NETWORKREQUEST_LOGIN_ERROR_USERNAME 用户名未找到
 *  error: b.NSNotification NETWORKREQUEST_LOGIN_ERROR_PASSWORD 密码错误
*         c.NSNotification NETWORKREQUEST_LOGIN_ERROR_FAILURE 网络请求失败
 *
 */
+ (void)loginRequestWithUserName:(NSString *)userName withPassword:(NSString *)password;

/**
 *  complete user infomation API
 *
 *  @param userName
 *  @param currentSchool
 *  @param targetSchool
 *
 *  success: NSNotification NETWORKREQUEST_INFO_SUCCESS
 *  error: a.NSNotification NETWORKREQUEST_INFO_ERROR_INVALID 用户ID错误，请重新登录
 *         b.NSNotification NETWORKREQUEST_INFO_ERROR_USERNAME 用户名重复
 *         c.NSNotification NETWORKREQUEST_INFO_ERROR_FAILURE 网络请求失败
 *
 */
+ (void)completeUserInfoWithUserName:(NSString *)userName withCurrentSchool:(NSString *)currentSchool withTargetSchool:(NSString *)targetSchool;

/**
 *  uploadSituationAPI
 *  after completing 1 question, post the result to Server
 *
 *  @param questionID int
 *  @param answer    the answer that user choosen example:"a"
 *  @param time       time withformat seconds
 *  success: NSNotification NETWORKREQUEST_UPLOAD_SUCCESS
 *  error: a.NSNotification NETWORKREQUEST_UPLOAD_ERROR_INVALID 用户ID错误，请重新登录
 *         b.NSNotification NETWORKREQUEST_UPLOAD_ERROR_FAILURE 网络请求失败
 */
+ (void)uploadSubjectSituationWithQuestionID:(int)questionID withAnswer:(NSString *)answer withTime:(int)time;

/**
 *  getReportAPI
 *  after completing 5 questions, post 5 questionID for getting the report
 *
 *  @param questionID 5 questions id example:"1,2,3,4,5"
 *
 *  success: NSNotification NETWORKREQUEST_REPORT_SUCCESS
 *  error: a.NSNotification NETWORKREQUEST_REPORT_ERROR_INVALID 用户ID错误，请重新登录
 *         b.NSNotification NETWORKREQUEST_REPORT_ERROR_FAILURE 网络请求失败
 */
+ (void)getReportWithQuestionID:(NSString *)questionID;


/**
 *  request Record Index
 *
 *  success: NSNOtification NETWORKREQUEST_RECORD_SUCCESS
 *  error:  a.NSNotification NETWORKREQUEST_RECORD_ERROR_INVALID 用户名ID错误，请重新登录
 *          b.NSNotification NETWORKREQUEST_RECORD_ERROR_FAILURE 网络请求失败
 */
+ (void)getRecordIndex;

/**
 *  request strength train list items
 *
 *  success: NSNotification NETWORKREQUEST_TRAIN_SUCCESS
 *  error: a.NSNotification NETWORKREQUEST_TRAIN_ERROR_INVALID
 *         b.NSNotification NETWORKREQUEST_TRAIN_ERROR_FALIURE
 */
+ (void)requestTrainList;

/**
 *  request subject with spectial knowledgeID
 *
 *  @param knowledgeID
 *  
 *  success: NSNotification NETWORKREQUEST_SUBJECTBYID_SUCCESS
 *  error:  a.NSNotification NETWORKREQUEST_SUBJECTBYID_ERROR_INVALID
 *          b.NSNotification NETWORKREQUEST_SUBJECTBYID_ERROR_FAILURE
 */
+ (void)requestSubjectByID:(NSString *)knowledgeID;

@end
