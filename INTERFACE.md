#iOS-PresentationLayer调用

PresentationLayer调用所需的函数都为静态函数。
调用之后均以广播的形式发送通知。

---
##网络请求-NetworkManager.h

####注册
>* registerRequest

>* 参数：
>>* phone:手机号
>>* password:密码(直接输入密码字符串，业务逻辑层会自行加密传送服务器）

>* 成功返回：
>>* NETWORKREQUEST_REGISTER_SUCCESS

>* 错误返回：
>>* NETWORKREQUEST_REGISTER_ERROR_INVALID   用户名未验证
>>* NETWORKREQUEST_REGISTER_ERROR_DUPLICATE 用户名已注册
>>* NETWORKREQUEST_REGISTER_FAILURE         网络请求失败

---

####登陆
>* loginRequest

>* 参数：
>>* userName:手机号/邮箱/用户名
>>* password:密码(直接输入密码字符串，业务逻辑层会自行加密传送服务器）

>* 成功返回：
>>* NETWORKREQUEST_LOGIN_SUCCESS
>* 错误返回：
>>* NETWORKREQUEST_LOGIN_ERROR_USERNAME 用户名未找到
>>* NETWORKREQUEST_LOGIN_ERROR_PASSWORD 密码错误
>>* NETWORKREQUEST_LOGIN_FAILURE        网络请求失败

---

####发送验证码
>* sendVerificationCode

>* 参数：
>>* phone:中国大陆11位电话号码

>* 成功返回：
>>* NETWORKREQUEST_SENDCODE_SUCCESS 发送验证码成功

>* 错误返回：
>>* NETWORKREQUEST_SENDCODE_FAILURE 发送验证码失败

---

####检测验证码
>* verifywithCode

>* 参数:
>>* phone:中国大陆11位电话号码
>>* code:短信验证码

>* 成功返回:
>>* NETWORKREQUEST_VERIFY_SUCCESS 验证成功

>* 失败返回:
>>* NETWORKREQUEST_VERIFY_FAILURE 验证失败

---

####完善用户信息
>* completeUserInfo

>* 参数:
>>* userName:用户名
>>* currentSchool:当前所在院校
>>* targetSchool:目标院校

>* 成功返回:
>>* NETWORKREQUEST_INFO_SUCCESS

>* 错误返回:
>>* NETWORKREQUEST_INFO_ERROR_INVALID 用户ID错误，请重新登录
>>* NETWORKREQUEST_INFO_ERROR_USERNAME 用户名重复
>>* NETWORKREQUEST_INFO_FAILURE 网络请求失败

---

####主页获取题目
>* getSubjects

>* 成功返回:之后可以获取处理之后的ModelManager里面的内容
>>* NETWORKREQUEST_SUBJECT_SUCCESS

>* 错误返回:
>>* NETWORKREQUEST_SUBJECT_ERROR_INVALID  用户ID错误，请重新登录
>>* NETWORKREQUEST_SUBJECT_FAILURE    网络请求失败

---

####答完一道题目之后上传结果
>* uploadSubjectSituation

>* 参数:
>>* questionID
>>* answer:选题结果“a"
>>* tiem:该题所耗用时间，单位为s

>* 成功返回:
>>* NETWORKREQUEST_UPLOAD_SUCCESS

>* 错误返回:
>>* NETWORKREQUEST_UPLOAD_ERROR_INVALID 用户ID错误，请重新登录
>>* NETWORKREQUEST_UPLOAD_FAILURE 网络请求失败

---

####答完一组题目之后获取报告
>* getReport

>* 参数:
>>* questionsID:一组题目的所有questionID,例如“121，122，123，124，125”

>* 成功返回:
>>* NETWORKREQUEST_REPORT_SUCCESS

>* 错误返回:
>>* NETWORKREQUEST_REPORT_ERROR_INVALID 用户ID错误，请重新登录
>>* NETWORKREQUEST_REPORT_FAILURE 网络请求失败

---

####获取主页记录信息
>* getRecordIndex

>* 成功返回:
>>* NETWORKREQUEST_RECORD_SUCCESS

>* 错误返回:
>>* NETWORKREQUEST_RECORD_ERROR_INVALID 用户名ID错误，请重新登录
>>* NETWORKREQUEST_RECORD_ERROR_FAILURE 网络请求失败

---

####获取强化训练列表
>* requestTrainList

>* 成功返回:
>>* NETWORKREQUEST_TRAIN_SUCCESS

>* 错误返回:
>>* NETWORKREQUEST_TRAIN_ERROR_INVALID
>>* NETWORKREQUEST_TRAIN_FALIURE

---

####根据指定知识点获取题目
>* requestSubjectByID

>* 参数:
>>* knowledgeID:知识点ID

>* 成功放回:
>>* NETWORKREQUEST_SUBJECTBYID_SUCCESS

>* 错误返回:
>>* NETWORKREQUEST_SUBJECTBYID_ERROR_INVALID
>>* NETWORKREQUEST_SUBJECTBYID_FAILURE

---
##题目模型——ModelManager.h

####题目
>* subjectArray
>>* content:题目内容
>>* answers:答案
>>* correctAnswer:正确答案
>>* thinkLabelID
>>* thinkLabel:标签内容

---

####报告
>* reportArray
>>* name
>>* knowledgeID
>>* score:当前得分
>>* variety:变动分数