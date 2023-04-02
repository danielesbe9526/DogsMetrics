//
//  DogRow.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 2/04/23.
//

import SwiftUI

struct DogRow: View {
    let dog: Dog
    
    var body: some View {
        HStack {
            Spacer()
            Text(dog.wrappedName)
            Image(systemName: "stroller")
                .foregroundColor(dog.color == "Macho" ? .blue : .pink)
            Spacer()
            
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.green, lineWidth: 2)
        }
    }
}

struct DogRow_Previews: PreviewProvider {
    static var previews: some View {
        DogRow(dog: DataController.dog)
    }
}
