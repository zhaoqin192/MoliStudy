//
//  NetworkManager.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {

    static let debug = true
   
    /**
     login API
     
     - parameter accountName: phone/email/userName
     - parameter password

     success: NETWORKREQUEST_LOGIN_SUCCESS
     error: a.NETWORKREQUEST_LOGIN_ERROR_USERNAME 用户名未找到
            b.NETWORKREQUEST_LOGIN_ERROR_PASSWORD 密码错误
            c.NETWORKREQUEST_LOGIN_FAILURE        网络请求失败
     */
    static func login(accountName: String, password: String){
        
        Alamofire.request(.POST,
            "http://www.molistudy.com/api/apiUser/login",
            parameters:["user_name":accountName, "password":UtilityManager.encryptPassword(password)])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        
                        AccountDAO.sharedManager.addAccount(accountName, password: password, userID:JSON["user_id"] as! String, userToken: JSON["user_token"] as! String)
                        
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_LOGIN_SUCCESS", object: nil)
                        
                    }else if errCode == 40002{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_LOGIN_ERROR_USERNAME", object: nil)
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_LOGIN_ERROR_PASSWORD", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_LOGIN_FAILURE", object: nil)
                    break
                }
        }
    }
    
    
    /**
     register API
     
     - parameter accountName: phone
     - parameter password
     
     success: NETWORKREQUEST_REGISTER_SUCCESS
     error  a.NETWORKREQUEST_REGISTER_ERROR_INVALID   用户名未验证
            b.NETWORKREQUEST_REGISTER_ERROR_DUPLICATE 用户名已注册
            c.NETWORKREQUEST_REGISTER_FAILURE
     */
    static func registerAccount(accountName: String, password: String){
        
        Alamofire.request(.POST,
            "http://www.molistudy.com/api/apiUser/register",
            parameters:["phone":accountName, "password":UtilityManager.encryptPassword(password)])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        
                        AccountDAO.sharedManager.addAccount(accountName, password: password, userID: JSON["user_id"] as! String, userToken: "")
                        
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_REGISTER_SUCCESS", object: nil)
                    }else if errCode == 40000{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_REGISTER_ERROR_INVALID", object: nil)
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_REGISTER_ERROR_DUPLICATE", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_REGISTER_FAILURE", object: nil)
                    break
                }
        }
    }
    
    /**
     find password
     
     - parameter userName
     - parameter password: new password
     
     success: NETWORKREQUEST_FIND_SUCCESS
     error  a.NETWORKREQUEST_FIND_ERROR_INVALID
            b.NETWORKREQUEST_FIND_ERROR
     */
    static func findPwd(userName: String, password: String){
        Alamofire.request(.POST, "http://www.molistudy.com/api/apiUser/findPwd",
            parameters:["user_name": userName, "password": UtilityManager.encryptPassword(password)])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_FIND_SUCCESS", object: nil)
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQEUST_FIND_ERROR_INVALID", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_FIND_ERROR", object: nil)
                    break
                }
        }
    }
    
    
    /**
     complete account information
     
     - parameter userName:
     - parameter currentSchool:
     - parameter targetSchool:  
     
     success: NETWORKREQUEST_INFO_SUCCESS
     error: a.NETWORKREQUEST_INFO_ERROR_INVALID
            b.NETWORKREQUEST_INFO_ERROR_USERNAME
            c.NETWORKREQUEST_INFO_FAILURE
     */
    static func completeUserInfo(userName: String, sex: NSNumber, academy: String, qq: String, introduction: String){
        let account = AccountDAO.sharedManager.findAccount()
        Alamofire.request(.POST,
            "http://www.molistudy.com/api/apiUser/completeInfo",
            parameters:["nick_name":userName, "user_token":account.token!, "sex": sex, "school": academy, "qq": qq, "self_introduction": introduction])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        AccountDAO.sharedManager.completeInfo(userName, sex: sex, academy: academy, qq: qq, introduction: introduction)
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_INFO_SUCCESS", object: nil)
                    }else if errCode == 40000{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_INFO_ERROR_INVALID", object: nil)
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_INFO_ERROR_USERNAME", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_INFO_FAILURE", object: nil)
                    break
                }
                
        }
    }
    
    /**
     send message to phone
     
     - parameter phone: 中国大陆11位手机号
     
     success: NETWORKREQUEST_SENDCODE_SUCCESS
     error:   NETWORKREQUEST_SENDCODE_FAILURE
     */
    static func sendVerficationCode(phone: String){
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: phone, zone: "86", customIdentifier: nil, result: {error in
            if error != nil{
                if debug{
                    print("Block获取验证码失败")
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SENDCODE_FAILURE", object: nil)
            }else{
                if debug{
                    print("Block获取验证码成功")
                }
                NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SENDCODE_SUCCESS", object: nil)
                
            }
        })
    }
    
    /**
     verify code and phone
     
     - parameter code:  message code
     - parameter phone
     
     success: NETWORKREQUEST_VERIFY_SUCCESS
     error:   NETWORKREQUEST_VERIFY_FAILURE
     */
    static func verify(code: String, phone: String){
        SMSSDK.commitVerificationCode(code, phoneNumber: phone, zone: "86", result: {error in
            if error != nil{
                if debug{
                    print("验证失败")
                }
                NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_VERIFY_FAILURE", object: nil)
            }else{
                if debug{
                    print("验证成功")
                }
                NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_VERIFY_SUCCESS", object: nil)
            }
        })
    }
    
    /**
     get random subject from server
     
     success: NETWORKREQUEST_SUBJECT_SUCCESS
     error: a.NETWORKREQUEST_SUBJECT_ERROR_INVALID
            b.NETWORKREQUEST_SUBJECT_FAILURE
     */
    static func getSubjects(viewID: String, course: String, completion:()->()){
        let account = AccountDAO.sharedManager.findAccount()
        Alamofire.request(.POST,
            "http://www.molistudy.com/api/apiStudy/getQuestion",
            parameters:["user_token":account.token!, "view_id": viewID, "course": course])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        SubjectDAO.sharedManager.addSubject(JSON["question_info"] as! NSArray)
                        completion()
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SUBJECT_ERROR_INVALID", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SUBJECT_FAILURE", object: nil)
                    break
                }
                
        }
    }
    
    /**
     upload answer after a question
     
     - parameter questionID
     - parameter answer:     example--"c"
     - parameter time:       seconds
     
     success: NETWORKREQUEST_UPLOAD_SUCCESS
     error: a.NETWORKREQUEST_UPLOAD_ERROR_INVALID
            b.NETWORKREQUEST_UPLOAD_FAILURE
     */
    static func uploadSubjectAnswer(questionID: NSNumber, answer: String, time: NSNumber, completion: () -> ()){
        let account = AccountDAO.sharedManager.findAccount()
        Alamofire.request(.POST,
            "http://www.molistudy.com/api/apiStudy/saveLog",
            parameters: ["user_id": account.userID!, "question_id": questionID, "choose_answer": answer, "study_time": time])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        completion()
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_UPLOAD_ERROR_INVALID", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_UPLOAD_FAILURE", object: nil)
                    break
                }
        }
    }
    
    /**
     get Report API
     
     - parameter questionIDs: example String--"121,122,123,124,125"
     
     success: NETWORKREQUEST_REPORT_SUCCESS
     error  a.NETWORKREQUEST_REPORT_ERROR_INVALID
            b.NETWORKREQUEST_REPORT_ERROR_FAILURE
     */
    static func getReport(questionIDs: String, completion: () -> ()){
        let account = AccountDAO.sharedManager.findAccount()
        Alamofire.request(.POST,
            "http://www.molistudy.com/api/apiStudy/getReport",
            parameters: ["user_id": account.userID!, "question_id": questionIDs])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        ReportDAO.sharedManager.addArray(JSON["study_report"] as! NSArray)
                        completion()
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_REPORT_ERROR_INVALID", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_REPORT_FAILURE", object: nil)
                    break
                }
        }
    }
    
    /**
     get record index API
     
     success: NETWORKREQUEST_RECORD_SUCCESS
     error: a.NETWORKREQUEST_RECORD_ERROR_INVALID
            b.NETWORKREQUEST_RECORD_ERROR_FAILURE
     */
    static func getRecordIndex(){
        let account = AccountDAO.sharedManager.findAccount()
        Alamofire.request(.POST,
            "http://www.molistudy.com/frontend/IOSAPI/index",
            parameters: ["user_id": account.userID!, "main_course_id": "1"])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_RECORD_SUCCESS", object: nil)
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_RECORD_ERROR_INVALID", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_RECORD_ERROR_FAILURE", object: nil)
                    break
                }
        }
    }
    
    /**
     get train list API
     
     success: NETWORKREQUEST_TRAIN_SUCCESS
     error: a.NETWORKREQUEST_TRAIN_ERROR_INVALID
            b.NETWORKREQUEST_TRAIN_FALIURE
     */
    static func requestTrainList(){
        let account = AccountDAO.sharedManager.findAccount()
        Alamofire.request(.POST,
            "http://www.molistudy.com/api/apiStudy/knowledgeTrain",
            parameters: ["user_id": account.userID!, "main_course_id": 1])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        
                        PracticeDAO.sharedManager.addPractice(JSON["know_info"] as! NSArray)
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_TRAIN_ERROR_INVALID", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_TRAIN_FALIURE", object: nil)
                    break
                }
        }
        
    }
    
    /**
     get special subject through knowledgeID
     
     - parameter knowledgeID
     
     success: NETWORKREQUEST_SUBJECTBYID_SUCCESS
     error: a.NETWORKREQUEST_SUBJECTBYID_ERROR_INVALID
            b.NETWORKREQUEST_SUBJECTBYID_FAILURE
     */
    static func requestSubjectByID(knowledgeID: NSNumber){
        let account = AccountDAO.sharedManager.findAccount()
        Alamofire.request(.POST,
            "http://www.molistudy.com/api/apiStudy/getQuesByKnowId",
            parameters: ["user_id": account.userID!, "knowledge_id": knowledgeID, "question_type": 1])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        SubjectDAO.sharedManager.addSubject(JSON["question_info"] as! NSArray)
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SUBJECTBYID_ERROR_INVALID", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_SUBJECTBYID_FAILURE", object: nil)
                    break
                }
        }
    }
    
//    /**
//     get the content of course
//     
//     - parameter course: the number of course
//    
//     success: NETWORKREQUEST_COURSEINDEX_SUCCESS
//     error: a.NETWORKREQUEST_COURSEINDEX_ERROR
//            b.NETWORKREQUEST_COURSEINDEX_FAILURE
//     */
//    static func getIndexCourse(course: String){
//        let account = AccountDAO.sharedManager.findAccount()
//        Alamofire.request(.POST,
//            "http://www.molistudy.com/api/apiCourse/index/course/3",
//            parameters: ["user_token": account.token!, "course": course])
//            .responseJSON{response in
//                switch response.result{
//                case .Success(let JSON):
//                    if debug{
//                        print(JSON)
//                    }
//                    let errCode = JSON["err_code"] as! NSNumber
//                    if errCode == 0{
//                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_COURSEINDEX_SUCCESS", object: nil)
//                    }else{
//                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_COURSEINDEX_ERROR", object: nil)
//                    }
//                    break
//                case .Failure(let error):
//                    if debug{
//                        print(error)
//                    }
//                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_COURSEINDEX_FAILURE", object: nil)
//                    break
//                }
//                
//        }
//    }
    
    /**
     click the detail of course, get the list for subject
     
     - parameter course: course id
     - parameter mode:   mode number
     
     success: NETWORKREQUEST_COURSELIST_SUCCESS
     error: a.NETWORKREQUEST_COURSELIST_ERROR
            b.NETWORKREQUEST_COURSELIST_FAILURE
     */
    
    static func getCourseList(course: String, mode: String){
        let account = AccountDAO.sharedManager.findAccount()
        print("token: " + account.token! + "course: " + course + "mode: " + mode)
        Alamofire.request(.POST, "http://www.molistudy.com/api/apiCourse/getView",
            parameters: ["user_token": account.token!, "course": course, "mode": mode])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        LevelDAO.sharedManager.addArray(JSON["viewList"] as! NSArray)
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_COURSELIST_ERROR", object: nil)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_COURSELIST_FAILURE", object: nil)
                    break
                }
        }
    }
    
    static func getQuestion(course: String, viewID: String){
        let account = AccountDAO.sharedManager.findAccount()
        Alamofire.request(.POST, "http://www.molistudy.com/api/apiStudy/getQuestion",
            parameters: ["user_token": account.token!, "course": course, "view_id": viewID])
            .responseJSON{response in
                switch response.result{
                case .Success(let JSON):
                    if debug{
                        print(JSON)
                    }
                    let errCode = JSON["err_code"] as! NSNumber
                    if errCode == 0{
                        SubjectDAO.sharedManager.addSubject(JSON["question"] as! NSArray)
                    }
                    break
                case .Failure(let error):
                    if debug{
                        print(error)
                    }
                }
                
        }
    }

}
