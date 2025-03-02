//
//  PartRepositoryImpl.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/3/25.
//

import Foundation

final class PartRepositoryImpl: PartRepositoryProtocol {
    
    public init(){}
    
    func fetchParts() async throws -> [PartModel] {
        do {
            let response: [PartModel] = try await NetworkService.request(endpoint: "/")
            return response
        } catch{
            throw error
        }
    }
}
