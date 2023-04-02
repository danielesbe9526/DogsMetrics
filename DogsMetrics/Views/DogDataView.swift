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
    let dog: Dog
    
    var body: some View {
        VStack {
            Text(dog.wrappedName)
            Chart(dog.weightRecordArray) { value in
                LineMark(x: .value("day", value.wrappedDate), y: .value("weigth", value.weigth))
                PointMark(x: .value("day", value.wrappedDate), y: .value("weigth", value.weigth))
            }.foregroundColor(.red)
        }
        .padding()
    }

}

struct DogDataView_Previews: PreviewProvider {
    static var previews: some View {
        DogDataView(dog: DataController.dog)
    }
}
