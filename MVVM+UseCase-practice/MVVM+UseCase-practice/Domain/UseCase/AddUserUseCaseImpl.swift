//
//  AddUserUseCaseImpl.swift
//  MVVM+UseCase-practice
//
//  Created by 이유현 on 3/10/25.
//

import Foundation

final class AddUserUseCaseImpl : AddUserUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(name: String, part: String) {
        if !name.isEmpty && !part.isEmpty {
            let newUser = UserModel(name: name, part: part)
            repository.addUser(newUser)
        }
    }
}
