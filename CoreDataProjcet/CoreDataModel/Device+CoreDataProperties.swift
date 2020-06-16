//
//  Device+CoreDataProperties.swift
//  CoreDataProjcet
//
//  Created by Bhabani on 15/06/20.
//  Copyright © 2020 Bhabani. All rights reserved.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var deviceName: String
    @NSManaged public var deviceType: String
    @NSManaged public var owner: Person?

}
