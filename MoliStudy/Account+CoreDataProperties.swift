//
//  Account+CoreDataProperties.swift
//  MoliStudy
//
//  Created by zhaoqin on 1/22/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Account {

    @NSManaged var academy: String?
    @NSManaged var accountName: String?
    @NSManaged var introduction: String?
    @NSManaged var password: String?
    @NSManaged var qq: String?
    @NSManaged var sex: NSNumber?
    @NSManaged var userID: String?
    @NSManaged var userName: String?
    @NSManaged var token: String?

}
