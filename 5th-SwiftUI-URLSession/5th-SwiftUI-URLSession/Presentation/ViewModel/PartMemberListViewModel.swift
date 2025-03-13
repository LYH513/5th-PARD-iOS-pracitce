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
    
    private let partUseCase : PartUseCaseProtocol
    private let partMemberUseCase: PartMemberUseCaseProtocol
    
    init(partUseCase: PartUseCaseProtocol, partMemberUseCase: PartMemberUseCaseProtocol) {
        self.partUseCase = partUseCase
        self.partMemberUseCase = partMemberUseCase
    }
    
    
    //MARK: - UseCase 호출 Fuction
    
}
