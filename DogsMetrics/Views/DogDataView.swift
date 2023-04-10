//
//  DogDataView.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 2/04/23.
//

import Foundation
import SwiftUI
import Charts



struct DogDataView: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var needsRefresh: Bool
    @State var needsRefreshForEdit: Bool = false
    let dog: Dog
    
    var body: some View {
        @State var dataArray: [DogData] = dog.weightRecordArray.reversed()
        
        NavigationStack {
            Chart(dataArray) { value in
                LineMark(x: .value("day", value.wrappedDate),
                         y: .value("weigth", value.weigth))
                PointMark(x: .value("day", value.wrappedDate),
                          y: .value("weigth", value.weigth))
                
            }
            .foregroundColor(Color(dog.wrappedColor))
            .padding()
            Spacer(minLength: 30)
            List {
                ForEach(dataArray.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            Text(String(format: "%.f gr", dataArray[index].weigth))
                                .padding(.horizontal)
                            Spacer()
                            setUpImagerFor(dataArray: dataArray, index: index)
                        }
                        
                        HStack {
                            Text(formatDate(date: dataArray[index].wrappedDate))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            Spacer()
                            setUpImagerFor(dataArray: dataArray, index: index,withTheInitial: true)
                        }
                    }
                }.onDelete(perform: removeData)
            }
            HStack {
                Text("Gender")
                    .accentColor(needsRefreshForEdit ? .primary : .secondary)
                Image(systemName: "pawprint.circle")
                    .foregroundColor(dog.gender == "Male" ? .blue : .pink)
            }.padding()
        }
        .onDisappear(perform: {
            needsRefresh.toggle()
        })
        
        .navigationTitle(dog.wrappedName)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                NavigationLink("Add") {
                    AddDogData(dog: dog, neddsRefresh: $needsRefreshForEdit)
                }.accentColor(.blue)

                
                NavigationLink("Edit") {
                    AddPuppyView(dogToEdit: dog, needsRefresh: $needsRefreshForEdit)
                }
                .accentColor(.blue)
            }
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM d, yyyy"
        return dateFormater.string(from: date)
    }
    
    func removeData(at offsets: IndexSet) {
        for index in offsets {
            let data = dog.weightRecordArray[index]
            DataController.shared.deleteData(context: moc, dog: dog, data: data)
            needsRefreshForEdit.toggle()
        }
    }
}

@ViewBuilder func setUpImagerFor(dataArray: [DogData], index: Int, withTheInitial: Bool = false) -> some View {
    if index + 1 < dataArray.count {
        let comparation = (withTheInitial ? dataArray.last?.weigth : dataArray[index + 1].weigth) ?? 0
        let isUpper = dataArray[index].weigth > comparation
        let image = Image(systemName: isUpper ? "arrow.up" : "arrow.down").foregroundColor(isUpper ? .green : .red)
   
        
        let percent: Int = Int(((dataArray[index].weigth * 100) / comparation) - 100)
        HStack {
            Text(withTheInitial ? "with initial" : "with last")
                .foregroundColor(.secondary)
            image
            Text("\(percent)%")
                .foregroundColor(.gray)
        }
    } else {
        EmptyView()
    }
}


struct DogDataView_Previews: PreviewProvider {
    static var previews: some View {
        DogDataView(needsRefresh: .constant(false), needsRefreshForEdit: false, dog: DataController.dog)
    }
}
