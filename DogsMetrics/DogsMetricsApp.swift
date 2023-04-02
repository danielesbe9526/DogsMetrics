//
//  DogsMetricsApp.swift
//  DogsMetrics
//
//  Created by Daniel Beltran on 1/04/23.
//

import SwiftUI

@main
struct DogsMetricsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
