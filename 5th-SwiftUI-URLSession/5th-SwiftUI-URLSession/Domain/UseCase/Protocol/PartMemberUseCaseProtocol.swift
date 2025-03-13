//
//  PartMemberUseCaseProtocol.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/13/25.
//

import Foundation

protocol PartMemberUseCaseProtocol {
    
    func getPartMembers(partId: String) async throws -> [PartMemberModel]
    
    func getPartMember(partId: String, memberId: String) async throws -> PartMemberModel
    
    func createPartMember(partId: String, member: PartMemberModel) async throws -> Bool
    
    func editPartMember(partId: String, memberId: String, newData: PartMemberModel) async throws -> Bool
    
    func removePartMember(partId: String, memberId: String) async throws -> Bool
    
}
