//
//  ContentView.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 1/04/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var dogs: FetchedResults<Dog>
//    var mockedDogs: [Dog] = []
    
    var body: some View {
//        NavigationStack {
//            List(mockedDogs) { dog in
//                Text(dog.wrappedName)
//            }
//        }
        
        VStack {
            List {
                ForEach(dogs, id: \.self) { dog in
                    Section(dog.wrappedName) {
                        ForEach(dog.weightRecordArray, id: \.self) { record in
                            Text("\(record.weigth.formatted()) gr")
                        }
                    }
                }.onDelete(perform: removeLanguages)
            }
        }
        .padding()
    }
    
    func removeLanguages(at offsets: IndexSet) {
        for index in offsets {
            let dog = dogs[index]
            DataController().delete(context: moc, dog: dog)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
