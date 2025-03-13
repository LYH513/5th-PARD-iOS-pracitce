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
    
    func fetchPartById(_ partId: String) async throws -> PartModel{
        do {
            let response: PartModel = try await NetworkService.request(endpoint: "/\(partId)")
            return response
        } catch{
            throw error
        }
    }
    
    
    func postPart(_ data : PartModel) async throws {
        do {
            let response: APIResponse = try await NetworkService.request(
                endpoint: "/",
                body: data ,
                method: "POST")
            
            print("✅ part POST 성공")
            
        } catch{
            throw error
        }
    }
    
    func updatePartById(_ partId: String, data: PartModel) async throws {
        do {
            let response: APIResponse = try await NetworkService.request(
                endpoint: "/\(partId)",
                body: data ,
                method: "PUT")
            
            print("✅ part PUT 성공")
            
        } catch{
            throw error
        }
    }
    
    func deletePartByById(_ partId: String) async throws {
        do {
            let response: PartModel = try await NetworkService.request(
                endpoint: "/\(partId)",
                method: "DELETE"
            )
          
            print("✅ part DELETE 성공")
            
        } catch{
            throw error
        }
    }
}
