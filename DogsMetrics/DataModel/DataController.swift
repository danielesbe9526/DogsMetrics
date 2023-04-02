//
//  DataController.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 1/04/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DogsDataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data...")
        }
    }
    
    func addDog(context: NSManagedObjectContext, name: String, image: String, color: String) {
        let dog = Dog(context: context)
        dog.id = UUID()
        dog.name = name
        
        save(context: context)
    }
    
    func addDogData(context: NSManagedObjectContext, dog: Dog, weigth: Double, dogDataName: String? = "") {
        let dogData = DogData(context: context)
        dogData.date = Date()
        dogData.weigth = weigth
        dog.addToWeightRecord(dogData)
        
        save(context: context)
    }
    
    func delete(context: NSManagedObjectContext, dog: Dog) {
        context.delete(dog)
        save(context: context)
    }
}
