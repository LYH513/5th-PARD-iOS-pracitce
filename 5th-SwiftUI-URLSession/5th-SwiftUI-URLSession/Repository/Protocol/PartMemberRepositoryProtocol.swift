//
//  PartMemberRepositoryProtocol.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/3/25.
//

import Foundation

protocol PartMemberRepositoryProtocol {
    func fetchPartMembers() async throws -> [PartMemberModel]
}
