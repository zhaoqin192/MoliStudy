//
//  LevelDAO.swift
//  MoliStudy
//
//  Created by zhaoqin on 2/18/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

import Foundation

class LevelDAO: NSObject{
    
    static let sharedManager = LevelDAO()
    var levelArray: [Level]
    
    override init() {
        levelArray = []
    }
    
    func findAll() -> [Level]{
        return levelArray
    }
    
    func addArray(array: NSArray){
        levelArray.removeAll()
        
        for i in 0...array.count - 1{
            let levelDic = array[i] as! NSDictionary
            let level = Level()
            level.id = levelDic["id"] as! String
            level.name = levelDic["name"] as! String
            levelArray.append(level)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("NETWORKREQUEST_COURSELIST_SUCCESS", object: nil)
    }
    
}