//
//  PardMemberListView.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/3/25.
//

import SwiftUI

struct PardMemberListView: View {
    
    @State private var partMemberListViewModel : PartMemberListViewModel
    
    init(partMemberListViewModel: PartMemberListViewModel) {
        self.partMemberListViewModel = partMemberListViewModel
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                
            }
            .navigationTitle("🌊 PARD 5기 멤버 리스트 🌊")
            .navigationBarTitleDisplayMode(.inline)
            
        } // : NavigationStack
        .task {
            await partMemberListViewModel.getAllPartsMembers()
        }
    }
}

#Preview {
    let partRepository = PartRepositoryImpl()
    let viewModel = PartMemberListViewModel(partRepository: partRepository)
    
    PardMemberListView(partMemberListViewModel: viewModel)
}
