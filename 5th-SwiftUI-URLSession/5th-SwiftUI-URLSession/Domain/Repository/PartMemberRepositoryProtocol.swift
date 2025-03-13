//
//  PartMemberRepositoryProtocol.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/3/25.
//

import Foundation

protocol PartMemberRepositoryProtocol {
    func fetchPartMembers(_ partId: String) async throws -> [PartMemberModel]
    func fetchPartMemberById(_ partId: String, memberId: String) async throws -> PartMemberModel
    func postPartMember(_ partId: String, data : PartMemberModel) async throws
    func updatePartMemberById(_ partId: String, memberId: String, data: PartMemberModel) async throws
    func deletePartMemberByById(_ partId: String,  memberId: String) async throws
}
