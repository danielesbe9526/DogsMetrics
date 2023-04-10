//
//  AddPuppyView.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 2/04/23.
//

import SwiftUI

struct AddPuppyView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    var dogToEdit: Dog?
    @State var name: String = ""
    @State private var index = 0
    @State private var puppyColor = Color.blue
    @Binding var needsRefresh: Bool
    
    var genderOptions = ["Male", "Female"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("profile")) {
                    TextField("Name", text: $name)
                    Picker(selection: $index) {
                        ForEach(0..<genderOptions.count) {
                            Text(genderOptions[$0])
                        }
                    } label: {
                        Text("Gender")
                    }
                }
                
                Section(header: Text("customize")) {
                    ColorPicker("Set Puppy Color", selection: $puppyColor)
                        .padding()

                }
                
                Section {
                    Button(action: {
                        if let dogToEdit {
                            DataController.shared.modifyDog(context: moc,
                                                            dog: dogToEdit,
                                                            name: name,
                                                            color: puppyColor.cgColor?.components,
                                                            gender: genderOptions[index])
                        } else {
                            DataController.shared.addDog(context: moc, name: name, color: puppyColor.cgColor?.components, gender: genderOptions[index])
                        }
                        needsRefresh.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save Puppy")
                    }
                }
            }
        }
    }
}

struct AddPuppyView_Previews: PreviewProvider {
    static var previews: some View {
        AddPuppyView(needsRefresh: .constant(false))
    }
}
