//
//  Bread_ButterApp.swift
//  Bread&Butter
//
//  Created by Oliwier Kasprzak on 26/02/2023.
//

import SwiftUI

@main
struct Bread_ButterApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
               .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
