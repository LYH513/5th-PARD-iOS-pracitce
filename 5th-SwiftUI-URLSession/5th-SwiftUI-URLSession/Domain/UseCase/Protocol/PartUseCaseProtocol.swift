//
//  PartUseCaseProtocol.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/13/25.
//

import Foundation

protocol PartUseCaseProtocol {
    func getParts() async throws -> [PartModel]
    
    func getPart(id: String) async throws -> PartModel
    
    func createPart(_ part: PartModel) async throws -> Bool
    
    func editPart(id: String, newData: PartModel) async throws -> Bool
    
    func removePart(id: String) async throws -> Bool
}
