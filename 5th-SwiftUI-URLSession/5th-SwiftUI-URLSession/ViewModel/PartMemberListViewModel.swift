//
//  PartMemberListViewModel.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/3/25.
//

import Foundation
import Observation

@Observable
final class PartMemberListViewModel {
    
    var partsList: [PartModel] = []
    
    private let partRepository : PartRepositoryProtocol
    private let memberRepository : PartMemberRepositoryProtocol
    
    init(partRepository: PartRepositoryProtocol,
         memberRepository: PartMemberRepositoryProtocol) {
        self.partRepository = partRepository
        self.memberRepository = memberRepository
    }
    
    func getAllPartsMembers() async {
        do{
            partsList = try await partRepository.fetchParts()
        } catch{
            print("❌ Error : \(error)")
        }
    }
    
}
