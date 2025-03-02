//
//  PartRepositoryProtocol.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/3/25.
//

import Foundation

protocol PartRepositoryProtocol {
    func fetchParts() async throws -> [PartModel]
}
