//
//  SignalingModel.swift
//  SignalingServer
//
//  Created by Sreekuttan D on 04/12/22.
//

import Foundation
import Network

public class SignalingModel: ObservableObject {
    
    private let port: NWEndpoint.Port = 8080
    
    private let server: WebSocketServer?
    
    public var connection: URL? = nil
    
    @Published public var isAlive: Bool = false
    
    public init() {
        server = try? WebSocketServer(port: port)
    }
    
    public func startServer() {
        guard let server = server else {
            return
        }
        
        server.start()
        
        let ip = getIPAddress()
        connection = URL(string: "ws://\(ip):\(server.port)")
        print(connection?.absoluteString ?? "")
        isAlive = true
    }
    
    private func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                    // wifi = ["en0"]
                    // wired = ["en2", "en3", "en4"]
                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }

}
