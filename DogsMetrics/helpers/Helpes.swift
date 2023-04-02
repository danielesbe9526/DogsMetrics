//
//  Helpers.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 2/04/23.
//

import Foundation

class Helpers {
    static var addMockedDogs: [Dog] {
        let newDog = Dog()
        newDog.name = "Blue dog"
        newDog.id = UUID()
        newDog.color = "M"
        
        let dogData = DogData()
        dogData.date = Date()
        dogData.weigth = 150
        
        let dogData2 = DogData()
        dogData2.date = Date()
        dogData2.weigth = 200
        
//        newDog.addToWeightRecord(dogData)
//        newDog.addToWeightRecord(dogData2)
        
        return [newDog]
    }
}
