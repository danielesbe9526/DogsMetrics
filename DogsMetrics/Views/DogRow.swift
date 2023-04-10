//
//  DogRow.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 2/04/23.
//

import SwiftUI

struct DogRow: View {
    let dog: Dog
    @Binding var neddsRefresh: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Text(dog.wrappedName)
                .accentColor(neddsRefresh ? .primary : .secondary)
            Image(systemName: "pawprint.circle")
                .foregroundColor(dog.gender == "Male" ? .blue : .pink)
            Spacer()
            
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(dog.wrappedColor), lineWidth: 2)
        }
    }
}

struct DogRow_Previews: PreviewProvider {
    static var previews: some View {
        DogRow(dog: DataController.dog, neddsRefresh: .constant(false))
    }
}
