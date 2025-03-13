//
//  PartUseCaseImpl.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/13/25.
//

import Foundation

final class PartUseCaseImpl : PartUseCaseProtocol {
    
    private let repository: PartRepositoryProtocol
    
    init(repository: PartRepositoryProtocol) {
        self.repository = repository
    }
    
    func getParts() async throws -> [PartModel] {
        do {
            return try await repository.fetchParts()
        } catch {
            print("❌ [UseCase] 파트 리스트 가져오기 실패: \(error.localizedDescription)")
            throw error
        }
    }

    func getPart(id: String) async throws -> PartModel {
        do {
            return try await repository.fetchPartById(id)
        } catch {
            print("❌ [UseCase] 파트 하나 가져오기 실패 (id: \(id)): \(error.localizedDescription)")
            throw error
        }
    }

    func createPart(_ part: PartModel) async throws -> Bool {
        do {
            try await repository.postPart(part)
            print("✅ [UseCase] 파트 생성 성공")
            return true
        } catch {
            print("❌ [UseCase] 파트 생성 실패: \(error.localizedDescription)")
            throw error
        }
    }

    func editPart(id: String, newData: PartModel) async throws -> Bool {
        do {
            try await repository.updatePartById(id, data: newData)
            print("✅ [UseCase] 파트 수정 성공 (id: \(id))")
            return true
        } catch {
            print("❌ [UseCase] 파트 수정 실패 (id: \(id)): \(error.localizedDescription)")
            throw error
        }
    }

    func removePart(id: String) async throws -> Bool {
        do {
            try await repository.deletePartByById(id)
            print("✅ [UseCase] 파트 삭제 성공 (id: \(id))")
            return true
        } catch {
            print("❌ [UseCase] 파트 삭제 실패 (id: \(id)): \(error.localizedDescription)")
            throw error
        }
    }

    
}
