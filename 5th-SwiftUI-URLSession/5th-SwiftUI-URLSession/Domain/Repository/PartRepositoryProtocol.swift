//
//  PartRepositoryProtocol.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/3/25.
//

import Foundation

protocol PartRepositoryProtocol {
    func fetchParts() async throws -> [PartModel]
    func fetchPartById(_ partId: String) async throws -> PartModel
    func postPart(_ data : PartModel) async throws //성공시 아무것도 안 받고 실패시 throw
    func updatePartById(_ partId: String, data: PartModel) async throws
    func deletePartByById(_ partId: String) async throws
}
