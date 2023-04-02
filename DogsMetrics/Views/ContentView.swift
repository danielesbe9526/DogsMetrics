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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dogs, id: \.self) { dog in
                    NavigationLink {
                        DogDataView(dog: dog)
                    } label: {
                        DogRow(dog: dog)
                    }
                }.onDelete(perform: removeLanguages)
            }
            .navigationTitle("Puppies")
        }
    }
    
    func removeLanguages(at offsets: IndexSet) {
        for index in offsets {
            let dog = dogs[index]
            DataController.shared.delete(context: moc, dog: dog)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.managedObjectContext, DataController.shared.container.viewContext)
    }
}
