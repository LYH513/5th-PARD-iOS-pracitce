//
//  _th_SwiftUI_URLSessionApp.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/1/25.
//

import SwiftUI

@main
struct _th_SwiftUI_URLSessionApp: App {
    var body: some Scene {
        
        // repository
        let partRepository = PartRepositoryImpl()
        let partMemberRepository = PartMemberRepositoryImpl()
        
        // UseCase
        let partUseCase = PartUseCaseImpl(repository: partRepository)
        let partMemberUseCase = PartMemberUseCaseImpl(repository: partMemberRepository)
        
        // ViewModel
        let viewModel = PartMemberListViewModel(
            partUseCase: partUseCase,
            partMemberUseCase: partMemberUseCase
        )
        
        WindowGroup {
            PardMemberListView(partMemberListViewModel: viewModel)
        }
    }
}
