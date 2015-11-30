//
//  ContextDAO.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//

import UIKit

class ContextDAO: NSObject {

    static let sharedInstance = ContextDAO()
    let appDelegate: AppDelegate
    let appContext: NSManagedObjectContext
    
    override init() {
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appContext = appDelegate.managedObjectContext
    }
}
