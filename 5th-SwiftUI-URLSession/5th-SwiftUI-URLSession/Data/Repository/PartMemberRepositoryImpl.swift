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

    func fetchPartMemberById(_ partId: String, memberId: String) async throws -> PartMemberModel {
        do {
            let response: PartMemberModel = try await NetworkService.request(endpoint: "/\(partId)/member/\(memberId)")
            return response
        } catch{
            throw error
        }
    }
    
    func postPartMember(_ partId: String, data : PartMemberModel) async throws {
        do {
            let response: APIResponse = try await NetworkService.request(
                endpoint: "/\(partId)/member",
                body: data ,
                method: "POST")
            
            print("✅ partMember POST 성공")
            
        } catch{
            throw error
        }
    }
    
    func updatePartMemberById(_ partId: String, memberId: String, data: PartMemberModel) async throws {
        do {
            let response: APIResponse = try await NetworkService.request(
                endpoint: "/\(partId)/member/\(memberId)",
                body: data ,
                method: "PUT")
            
            print("✅ partMember PUT 성공")
            
        } catch{
            throw error
        }
    }
    
    func deletePartMemberByById(_ partId: String,  memberId: String) async throws{
        do {
            let response: APIResponse = try await NetworkService.request(
                endpoint: "/\(partId)/member/\(memberId)",
                method: "DELETE")
            
            print("✅ partMember DELETE 성공")
            
        } catch{
            throw error
        }
        
    }
}
