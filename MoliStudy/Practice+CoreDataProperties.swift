//
//  Practice+CoreDataProperties.swift
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

extension Practice {

    @NSManaged var finished: NSNumber?
    @NSManaged var itemID: NSNumber?
    @NSManaged var name: String?
    @NSManaged var total: NSNumber?

}
