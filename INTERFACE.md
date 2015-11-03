#服务器

请求使用POST方法，返回JSON数据格式（所有都是key-value字符串形式）

所有的错误返回形式如下：
```
{text, errcode, status}
```

---
##答题

####答题结束返回本次答题结果
>* /apis/answer/feedback

>* 参数：
>>* token:必须
>>* id:题目id
>>* accuracy:正确率

>* 成功返回：
>>* {status}

>* 错误返回：
>>* errcode = 0:用户id错误
>>* errcode = 1:题目id错误

>* 样例：
```json
{"status": true}
```
```json
{"status": false, "errcode": 0, "text": "用户id错误"}
```

---
##强化训练

####列出强化训练项目
>* /apis/enhance/list

>* 参数：
>>* token:必须（登陆接口返回token,用于区别不同用户)

>* 成功返回：
>>* {status, items[{name, finished, total}]}
>>* name为项目名称
>>* finished为完成该项目的学习次数
>>* total为该项目的总次数

>* 错误返回：
>>* errcode = 0:用户token错误

>* 样例：
```json
{"status": true, "items":[{"name":"词汇", "finished": 34, "total": 100}, {"name":"动词", "finished": 52, "total": 100}, {"name":"形容词", "finished": 34, "total": 100}]}
```

##成绩报告

####成绩报告信息,返回该用户的总体成绩信息
>* /apis/score/index

>* 参数：
>>* token:必须

>* 成功返回：
>>* {status, forecast, accuracy, complete}
>>* forecast:预测分
>>* accuracy:正确率
>>* complete:完成题目数量

>* 错误返回：
>>* errcode = 0:用户token错误

>* 样例：
```json
{"status": true, "forecast": 72, "accuracy": "60%", "complete": 326}
```
