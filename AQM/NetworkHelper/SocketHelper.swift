//
//  SocketHelper.swift
//  AQM
//
//  Created by bharathi kumar on 09/12/21.
//

import Foundation
import SocketIO

class SocketHelper {

    static let shared = SocketHelper()
    var socket: SocketIOClient!
    
    let manager = SocketManager(socketURL: URL(string: "ws://city-ws.herokuapp.com/")!, config: [.log(true), .compress,.secure(false),.selfSigned(true),.forceWebsockets(true)])
    private init() {
        socket = manager.defaultSocket
    }

    func connectSocket(completion: @escaping(AQIData) -> () ) {
        disconnectSocket()
        socket.on(clientEvent: .connect) {[weak self] (data, ack) in
            print("socket connected")
            self?.socket.removeAllHandlers()
        }
        socket.on("error") { data, ack in
            if let name = data[0] as? String {
                print(name)
                let result = name.replacingOccurrences(of: "Got unknown error from server ", with: "")
                let jsonData = result.data(using: .utf8)
                let decoder = JSONDecoder()
                do {
                    let people = try decoder.decode(AQIData.self, from: jsonData ?? Data())
                    print(people)
                    completion(people)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        socket.connect()
    }
    func disconnectSocket() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }

    func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false
    }
}
