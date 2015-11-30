//
//  Account+CoreDataProperties.swift
//  MoliStudy
//
//  Created by zhaoqin on 11/30/15.
//  Copyright © 2015 MoliStudy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Account {

    @NSManaged var accountName: String?
    @NSManaged var currentAcademy: String?
    @NSManaged var password: String?
    @NSManaged var targetAcademy: String?
    @NSManaged var userID: String?
    @NSManaged var userName: String?

}
