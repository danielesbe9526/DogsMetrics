//
//  DogData+CoreDataProperties.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 1/04/23.
//
//

import Foundation
import CoreData


extension DogData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DogData> {
        return NSFetchRequest<DogData>(entityName: "DogData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var weigth: Double
    @NSManaged public var dog: Dog?
    
    public var wrappedDate: Date {
        date ?? Date()
    }
}

extension DogData : Identifiable {

}
