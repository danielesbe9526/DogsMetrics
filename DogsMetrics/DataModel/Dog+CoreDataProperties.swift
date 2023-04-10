//
//  Dog+CoreDataProperties.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 1/04/23.
//
//

import Foundation
import CoreData
import UIKit

extension Dog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dog> {
        return NSFetchRequest<Dog>(entityName: "Dog")
    }

    @NSManaged public var colorG: Float
    @NSManaged public var gender: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var colorR: Float
    @NSManaged public var colorA: Float
    @NSManaged public var colorB: Float
    @NSManaged public var weightRecord: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown Dog"
    }

    public var wrappedImage: String {
        image ?? "Unknown Dog"
    }
    
    public var wrappedGender: String {
        gender ?? "Unknown Gender"
    }
    
    public var wrappedColor: UIColor {
        guard let sp = CGColorSpace(name:CGColorSpace.genericRGBLinear) else { return .black }
        let comps : [CGFloat] = [CGFloat(colorR), CGFloat(colorG), CGFloat(colorB), CGFloat(colorA)]
        guard let c = CGColor(colorSpace: sp, components: comps),
              let sp2 = CGColorSpace(name:CGColorSpace.sRGB),
              let c2 = c.converted(to: sp2, intent: .relativeColorimetric, options: nil) else { return .black }
        return UIColor(cgColor: c2)
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
