//
//  MVVM_UseCase_practiceApp.swift
//  MVVM+UseCase-practice
//
//  Created by 이유현 on 3/6/25.
//

import SwiftUI

@main
struct MVVM_UseCase_practiceApp: App {
    
    var body: some Scene {
        
        // repository
        let repository = UserRepositoryImpl()
        
        // useCase
        let getUserListUseCaseImpl = GetUserListUseCaseImpl(repository: repository)
        let addUserUseCaseImpl = AddUserUseCaseImpl(repository: repository)
        
        //ViewModel
        let viewModel = UserViewModel(getUserListUseCase:getUserListUseCaseImpl , addUserUseCase: addUserUseCaseImpl)
        
        WindowGroup {
            UserListView(userViewModel : viewModel)
        }
    }
}
