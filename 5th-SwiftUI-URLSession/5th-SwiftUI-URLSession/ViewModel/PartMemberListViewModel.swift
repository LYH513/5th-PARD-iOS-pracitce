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
    
    private let repository : PartRepositoryProtocol
    
    init(partRepository: PartRepositoryProtocol) {
        self.repository = partRepository
    }
    
    func getAllPartsMembers() async {
        do{
            partsList = try await repository.fetchParts()
            print(partsList)
        } catch{
            print(error)
        }
    }
    
}
