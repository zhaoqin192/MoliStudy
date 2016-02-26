//
//  SubjectRecord.swift
//  MoliStudy
//
//  Created by zhaoqin on 2/26/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

import Foundation

class SubjectRecord: NSObject {
    var isChosen: Bool
    var option: NSInteger
    
    override init() {
        isChosen = false
        option = -1
    }
}