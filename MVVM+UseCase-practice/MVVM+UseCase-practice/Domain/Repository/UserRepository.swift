//
//  UserRepository.swift
//  MVVM+UseCase-practice
//
//  Created by 이유현 on 3/10/25.
//

import Foundation

protocol UserRepository {
    func fetchUsers() -> [UserModel]
    func addUser(_ newUser: UserModel)
}
