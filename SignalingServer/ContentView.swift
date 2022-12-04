//
//  ContentView.swift
//  SignalingServer
//
//  Created by Sreekuttan D on 04/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model: SignalingModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Group {
                if model.isAlive {
                    Text(model.connection?.absoluteString ?? "")
                            .textSelection(.enabled)
                } else {
                    Button{
                        if !model.isAlive {
                            model.startServer()
                        }
                    } label: {
                        Text("Start Server")
                            .font(.title)
                    }
                }
            }
            .padding()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    struct Preview: View {
        @StateObject private var model = SignalingModel()
        var body: some View {
            ContentView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
