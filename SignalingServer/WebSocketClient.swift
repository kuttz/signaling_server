//
//  WebSocketClient.swift
//  SignalingServer
//
//  Created by Sreekuttan D on 04/12/22.
//

import Foundation
import Network

final class WebSocketClient: Hashable, Equatable {
    
    let id: String
    let connection: NWConnection
    
    init(connection: NWConnection) {
        self.connection = connection
        self.id = UUID().uuidString
    }
    
    static func == (lhs: WebSocketClient, rhs: WebSocketClient) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
