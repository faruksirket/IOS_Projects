//
//  HelloCoreDataApp.swift
//  HelloCoreData
//
//  Created by faruk sirket on 7.01.2022.
//

import SwiftUI

@main
struct HelloCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManger())
        }
    }
}
