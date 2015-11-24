//
//  NetworkManager.h
//  MoliStudy
//
//  Created by zhaoqin on 11/22/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

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
*         c.NSNotification NETWORKREQUEST_LOGIN_FAILURE 网络请求失败
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
 *         c.NSNotification NETWORKREQUEST_INFO_FAILURE 网络请求失败
 *
 */
+ (void)completeUserInfoWithUserName:(NSString *)userName withCurrentSchool:(NSString *)currentSchool withTargetSchool:(NSString *)targetSchool;

/**
 *  get subject without knowledge_id
 *
 *  success: NETWORKREQUEST_SUBJECT_SUCCESS
 *  error:  a.NETWORKREQUEST_SUBJECT_ERROR_INVALID  用户ID错误，请重新登录
 *          b.NETWORKREQUEST_SUBJECT_FAILURE    网络请求失败
 */
+ (void)getSubjects;

/**
 *  uploadSituationAPI
 *  after completing 1 question, post the result to Server
 *
 *  @param questionID int
 *  @param answer    the answer that user choosen example:"a"
 *  @param time       time withformat seconds
 *  success: NSNotification NETWORKREQUEST_UPLOAD_SUCCESS
 *  error: a.NSNotification NETWORKREQUEST_UPLOAD_ERROR_INVALID 用户ID错误，请重新登录
 *         b.NSNotification NETWORKREQUEST_UPLOAD_FAILURE 网络请求失败
 */
+ (void)uploadSubjectSituationWithQuestionID:(NSString *)questionID withAnswer:(NSString *)answer withTime:(int)time;

/**
 *  getReportAPI
 *  after completing 5 questions, post 5 questionID for getting the report
 *
 *  @param questionID 5 questions id example:"1,2,3,4,5"
 *
 *  success: NSNotification NETWORKREQUEST_REPORT_SUCCESS
 *  error: a.NSNotification NETWORKREQUEST_REPORT_ERROR_INVALID 用户ID错误，请重新登录
 *         b.NSNotification NETWORKREQUEST_REPORT_FAILURE 网络请求失败
 */
+ (void)getReportWithQuestionID:(NSString *)questionsID;


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
 *         b.NSNotification NETWORKREQUEST_TRAIN_FALIURE
 */
+ (void)requestTrainList;

/**
 *  request subject with spectial knowledgeID
 *
 *  @param knowledgeID
 *  
 *  success: NSNotification NETWORKREQUEST_SUBJECTBYID_SUCCESS
 *  error:  a.NSNotification NETWORKREQUEST_SUBJECTBYID_ERROR_INVALID
 *          b.NSNotification NETWORKREQUEST_SUBJECTBYID_FAILURE
 */
+ (void)requestSubjectByID:(NSString *)knowledgeID;

/**
 *  send verification code to phone
 *
 *  @param phone 中国大陆11位手机号
 *  
 *  success: NETWORKREQUEST_SENDCODE_SUCCESS 发送验证码成功
 *  error:  NETWORKREQUEST_SENDCODE_FAILURE 发送验证码失败
 */
+ (void)sendVerificationCode:(NSString*)phone;

/**
 *  verify code and phone
 *
 *  @param code  4位验证码
 *  @param phone 中国大陆11位手机号
 *
 *  success: NETWORKREQUEST_VERIFY_SUCCESS 验证成功
 *  error: NETWORKREQUEST_VERIFY_FAILURE 验证失败
 */
+ (void)verifyWithCode:(NSString*)code withPhone:(NSString*)phone;

@end
