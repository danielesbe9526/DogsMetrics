//
//  AddDogData.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 2/04/23.
//

import SwiftUI

struct AddDogData: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    let dog: Dog

    @State var weigth: String = ""
    @State private var date = Date.now
    @State private var puppyColor = Color.blue
    @Binding var neddsRefresh: Bool

    
    var genderOptions = ["Male", "Female"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Daily Data")) {
                    TextField("weigth", text: $weigth)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                    DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                                  Text("Select a date")
                              }
                }
               
                Section {
                    Button(action: {
                        DataController.shared.addDogData(context: moc, dog: dog, weigth: Double(weigth) ?? 0.0, date: date)
                        neddsRefresh.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save Data")
                    }
                }
            }
        }
    }
}

struct AddDogData_Previews: PreviewProvider {
    static var previews: some View {
        AddDogData(dog: DataController.dog, neddsRefresh: .constant(false))
    }
}
