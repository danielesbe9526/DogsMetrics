//
//  ContentView.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 1/04/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var dogs: FetchedResults<Dog>
    @State var needsRefresh: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Table") {
                        ForEach(dogs, id: \.self) { dog in
                            NavigationLink {
                                DogDataView(needsRefresh: $needsRefresh, dog: dog)
                                    .accentColor(needsRefresh ? .primary : .secondary)
                            } label: {
                                DogRow(dog: dog, neddsRefresh: $needsRefresh)
                            }
                        }.onDelete(perform: removeDog)
                        
                    }
                    Section("Charts") {
                        Chart {
                            ForEach(dogs) { dog in
                                let dogWeigth = dog.weightRecordArray.last?.weigth ?? 0.0
                                BarMark(
                                    x: .value("Weigth", dogWeigth),
                                    y: .value("Name", dog.wrappedName))
                                .foregroundStyle(by: .value("Name",  dog.wrappedName))
                                .annotation(position: .trailing) {
                                    Text(getDogWeigth(dog: dog))
                                        .foregroundColor(.gray)
                                }
                            }
                        }.frame(height: 400)
                        .chartForegroundStyleScale(domain: dogs.compactMap({ dog in
                            dog.wrappedName
                        }), range: fillColors())
                        
                    }
                }
            }
            .navigationTitle("Puppies")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    NavigationLink("Add") {
                        AddPuppyView(needsRefresh: $needsRefresh)
                    }
                }
            }
            .onAppear {
                needsRefresh.toggle()
            }
        }
    }
    
    func fillColors() -> [Color] {
        var colors: [Color] = []
        dogs.forEach { dog in
            colors.append(Color(dog.wrappedColor))
        }
        return colors
    }
    
    func removeDog(at offsets: IndexSet) {
        for index in offsets {
            let dog = dogs[index]
            DataController.shared.delete(context: moc, dog: dog)
        }
    }
    
    func getDogWeigth(dog: Dog) -> String {
        "\(Int(dog.weightRecordArray.last?.weigth ?? 0.0))"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.managedObjectContext, DataController.shared.container.viewContext)
    }
}
