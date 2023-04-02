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
    static let shared = DataController()
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        createDogs(self.container.viewContext)
    }
    
    static var preview: DataController = {
        let result = DataController.shared
        let context = result.container.viewContext
                
        return result
    }()
    
    static var dog: Dog = {
        let result = DataController.shared
        let context = result.container.viewContext
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MM-dd-yyyy"
        
        let dog = Dog(context: context)
        dog.id = UUID()
        dog.name = "Mocked Dog"
        dog.color = "Macho"
        
        let dogData = DogData(context: context)
        dogData.date = myDateFormatter.date(from: "01/01/2023")
        dogData.weigth = 100
        dog.addToWeightRecord(dogData)
        
        let dogData2 = DogData(context: context)
        dogData2.date = myDateFormatter.date(from: "01/02/2023")
        dogData2.weigth = 150
        dog.addToWeightRecord(dogData2)
        
        let dogData3 = DogData(context: context)
        dogData3.date = myDateFormatter.date(from: "01/03/2023")
        dogData3.weigth = 200
        dog.addToWeightRecord(dogData3)
        
        let dogData4 = DogData(context: context)
        dogData4.date = myDateFormatter.date(from: "01/04/2023")
        dogData4.weigth = 180
        dog.addToWeightRecord(dogData4)
        
        let dogData5 = DogData(context: context)
        dogData5.date = myDateFormatter.date(from: "01/05/2023")
        dogData5.weigth = 320
        dog.addToWeightRecord(dogData5)
        
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data...")
        }
        
        return dog
    }()
    
    
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
    
    private func createDogs(_ context: NSManagedObjectContext) {
        // Dogs
        let dog = Dog(context: context)
        dog.id = UUID()
        dog.name = "Mocked Dog"
        dog.color = "Macho"
        
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
}
