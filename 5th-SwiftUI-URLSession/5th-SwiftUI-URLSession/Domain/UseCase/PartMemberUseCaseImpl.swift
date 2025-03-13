//
//  PartMemberUseCaseImpl.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/13/25.
//

import Foundation

final class PartMemberUseCaseImpl : PartMemberUseCaseProtocol {

    private let repository: PartMemberRepositoryProtocol
    
    init(repository: PartMemberRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPartMembers(partId: String) async throws -> [PartMemberModel] {
        do {
            return try await repository.fetchPartMembers(partId)
        } catch {
            print("❌ [UseCase] 파트 멤버 리스트 조회 실패 (partId: \(partId)): \(error.localizedDescription)")
            throw error
        }
    }
    
    func getPartMember(partId: String, memberId: String) async throws -> PartMemberModel {
        do {
            return try await repository.fetchPartMemberById(partId, memberId: memberId)
        } catch {
            print("❌ [UseCase] 파트 멤버 상세 조회 실패 (partId: \(partId), memberId: \(memberId)): \(error.localizedDescription)")
            throw error
        }
    }
    
    func createPartMember(partId: String, member: PartMemberModel) async throws -> Bool {
        do {
            try await repository.postPartMember(partId, data: member)
            print("✅ [UseCase] 파트 멤버 추가 성공 (partId: \(partId))")
            return true
        } catch {
            print("❌ [UseCase] 파트 멤버 추가 실패 (partId: \(partId)): \(error.localizedDescription)")
            throw error
        }
    }
    
    func editPartMember(partId: String, memberId: String, newData: PartMemberModel) async throws -> Bool {
        do {
            try await repository.updatePartMemberById(partId, memberId: memberId, data: newData)
            print("✅ [UseCase] 파트 멤버 수정 성공 (partId: \(partId), memberId: \(memberId))")
            return true
        } catch {
            print("❌ [UseCase] 파트 멤버 수정 실패 (partId: \(partId), memberId: \(memberId)): \(error.localizedDescription)")
            throw error
        }
    }
    
    func removePartMember(partId: String, memberId: String) async throws -> Bool {
        do {
            try await repository.deletePartMemberByById(partId, memberId: memberId)
            print("✅ [UseCase] 파트 멤버 삭제 성공 (partId: \(partId), memberId: \(memberId))")
            return true
        } catch {
            print("❌ [UseCase] 파트 멤버 삭제 실패 (partId: \(partId), memberId: \(memberId)): \(error.localizedDescription)")
            throw error
        }
    }
}
