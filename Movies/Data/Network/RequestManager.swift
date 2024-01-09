//
//  RequestManager.swift
//  Movies
//
//  Created by Jamile Bastos on 10/12/23.
//

import Foundation

protocol RequestManager {
    var networkManager: NetworkManager { get }
    var parser: DataParser { get }
    func makeRequest<T: Decodable>(with requestData: RequestProtocol) async throws -> T
}

class DefaultRequestManager: RequestManager {
    let networkManager: NetworkManager

    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }

    func makeRequest<T: Decodable>(with requestData: RequestProtocol) async throws -> T {
        let data = try await networkManager.makeRequest(with: requestData)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}

extension RequestManager {
    var parser: DataParser {
        return DefaultDataParser()
    }
}
