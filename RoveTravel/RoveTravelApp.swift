//
//  RoveApp.swift
//  Rove
//

import SwiftUI

@main
struct RoveApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(destination: Destination.previewDestination[0])
        }
    }
}
