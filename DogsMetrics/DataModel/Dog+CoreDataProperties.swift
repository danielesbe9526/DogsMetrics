//
//  Dog+CoreDataProperties.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 1/04/23.
//
//

import Foundation
import CoreData


extension Dog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dog> {
        return NSFetchRequest<Dog>(entityName: "Dog")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var color: String?
    @NSManaged public var weightRecord: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown Dog"
    }

    public var wrappedImage: String {
        image ?? "Unknown Dog"
    }
    
    public var wrappedColor: String {
        color ?? "Unknown Dog"
    }
    
    public var weightRecordArray: [DogData] {
        let set = weightRecord as? Set<DogData> ?? []
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }
}

// MARK: Generated accessors for weightRecord
extension Dog {

    @objc(addWeightRecordObject:)
    @NSManaged public func addToWeightRecord(_ value: DogData)

    @objc(removeWeightRecordObject:)
    @NSManaged public func removeFromWeightRecord(_ value: DogData)

    @objc(addWeightRecord:)
    @NSManaged public func addToWeightRecord(_ values: NSSet)

    @objc(removeWeightRecord:)
    @NSManaged public func removeFromWeightRecord(_ values: NSSet)

}

extension Dog : Identifiable {

}
