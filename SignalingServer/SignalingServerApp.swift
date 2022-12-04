//
//  SignalingServerApp.swift
//  SignalingServer
//
//  Created by Sreekuttan D on 04/12/22.
//

import SwiftUI

@main
struct SignalingServerApp: App {
    
    @StateObject private var model = SignalingModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
