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
        
        let partRepository = PartRepositoryImpl()
        let partMemberRepository = PartMemberRepositoryImpl()
        
        // 이 사이에 useCase가 있고, ViewModel에 전달하는게 useCase여야 하는데 일단 생략함
        let viewModel = PartMemberListViewModel(
            partRepository: partRepository,
            memberRepository: partMemberRepository)
        
        WindowGroup {
            PardMemberListView(partMemberListViewModel: viewModel)
        }
    }
}
