//
//  DataController.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 1/04/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentCloudKitContainer(name: "DogsDataModel")
    static let shared = DataController()
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        
        /// To solve conflicts automatically
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
//        createDogs(self.container.viewContext)
    }
    
    static var preview: DataController = {
        let result = DataController.shared
        let context = result.container.viewContext
                
        return result
    }()
    
    // MARK: - CoreKit
    
    
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data...")
        }
    }
    
    func modifyDog(context: NSManagedObjectContext, dog: Dog, name: String, color:[CGFloat]?, gender: String) {
        if !name.isEmpty {
            dog.name = name
        }
        if !gender.isEmpty {
            dog.gender = gender
        }
        if let color, !color.isEmpty {
            dog.colorR = Float(color[0])
            dog.colorG = Float(color[1])
            dog.colorB = Float(color[2])
            dog.colorA = Float(color[3])
        }
        
        save(context: context)
    }
    
    func addDog(context: NSManagedObjectContext, name: String, color: [CGFloat]?, gender: String) {
        let dog = Dog(context: context)
        dog.id = UUID()
        dog.name = name
        dog.colorR = Float(color?[0] ?? 0.0)
        dog.colorG = Float(color?[1] ?? 0.0)
        dog.colorB = Float(color?[2] ?? 0.0)
        dog.colorA = Float(color?[3] ?? 0.0)
        dog.gender = gender

        save(context: context)
    }
    
    func addDogData(context: NSManagedObjectContext, dog: Dog, weigth: Double, date: Date = Date(), dogDataName: String? = "") {
        let dogData = DogData(context: context)
        dogData.date = date
        dogData.weigth = weigth
        dog.addToWeightRecord(dogData)
        
        save(context: context)
    }
    
    func delete(context: NSManagedObjectContext, dog: Dog) {
        context.delete(dog)
        save(context: context)
    }
    
    func deleteData(context: NSManagedObjectContext, dog: Dog, data: DogData) {
        dog.removeFromWeightRecord(data)
        save(context: context)
    }
    
    func deleteAll(context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dog")
          fetchRequest.returnsObjectsAsFaults = false
          do {
              let results = try context.fetch(fetchRequest)
              for object in results {
                  guard let objectData = object as? NSManagedObject else {continue}
                  context.delete(objectData)
              }
          } catch let error {
              print("Detele all data in Dog error :", error.localizedDescription)
          }
        save(context: context)
    }
}

extension DataController {
    
    private func createDogs(_ context: NSManagedObjectContext) {
        // Dogs
        let dog = Dog(context: context)
        dog.id = UUID()
        dog.name = "Mocked Dog"
        dog.gender = "Male"
        
        let dogData = DogData(context: context)
        dogData.date = Date()
        dogData.weigth = 100
        dog.addToWeightRecord(dogData)
        
        let dogData2 = DogData(context: context)
        dogData2.date = Date()
        dogData2.weigth = 150
        dog.addToWeightRecord(dogData2)
        
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data...")
        }
    }

    
    static var dog: Dog = {
        let result = DataController.shared
        let context = result.container.viewContext
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MM-dd-yyyy"
        
        let dog = Dog(context: context)
        dog.id = UUID()
        dog.name = "Mocked Dog"
        dog.gender = "Female"
        dog.colorA = 1
        dog.colorR = 0.14
        dog.colorG = 0.29
        dog.colorB = 0.15
        
        let dogData = DogData(context: context)
        dogData.date = myDateFormatter.date(from: "01/01/2023")
        dogData.weigth = 100
        dog.addToWeightRecord(dogData)
        
        let dogData2 = DogData(context: context)
        dogData2.date = myDateFormatter.date(from: "01/02/2023")
        dogData2.weigth = 120
        dog.addToWeightRecord(dogData2)
        
        let dogData3 = DogData(context: context)
        dogData3.date = myDateFormatter.date(from: "01/03/2023")
        dogData3.weigth = 180
        dog.addToWeightRecord(dogData3)
        
        let dogData4 = DogData(context: context)
        dogData4.date = myDateFormatter.date(from: "01/04/2023")
        dogData4.weigth = 150
        dog.addToWeightRecord(dogData4)
        
        let dogData5 = DogData(context: context)
        dogData5.date = myDateFormatter.date(from: "01/05/2023")
        dogData5.weigth = 180
        dog.addToWeightRecord(dogData5)
        
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data...")
        }
        
        return dog
    }()
}
