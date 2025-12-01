//
//  BackgroundableSampleApp.swift
//  BackgroundableSample
//  
//  Created by Masato Takimoto on 2025/11/26.
//  
//

import SwiftUI

@main
struct BackgroundableSampleApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Struct Base", systemImage: "60.arrow.trianglehead.counterclockwise") {
                    ContentView()
                }
                Tab("Class Base" ,systemImage: "60.arrow.trianglehead.counterclockwise") {
                    ClassBaseView()
                }
                Tab("Actor Base" ,systemImage: "60.arrow.trianglehead.counterclockwise") {
                    ActorBaseView()
                }
            }
        }
    }
}
