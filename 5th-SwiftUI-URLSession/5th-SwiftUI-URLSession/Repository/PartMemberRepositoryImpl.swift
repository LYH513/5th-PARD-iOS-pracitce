//
//  PartMemberRepositoryImpl.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/3/25.
//

import Foundation

final class PartMemberRepositoryImpl: PartMemberRepositoryProtocol {
    
    public init(){}
    
    func fetchPartMembers(_ partId: String) async throws -> [PartMemberModel] {
        do {
            let response: [PartMemberModel] = try await NetworkService.request(endpoint: "/\(partId)/member")
            return response
        } catch{
            throw error
        }
    }
}
