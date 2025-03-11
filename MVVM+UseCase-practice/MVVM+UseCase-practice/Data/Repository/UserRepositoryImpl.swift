//
//  UserRepositoryImpl.swift
//  MVVM+UseCase-practice
//
//  Created by 이유현 on 3/10/25.
//

import Foundation

final class UserRepositoryImpl : UserRepository {
    
    // 서버의 데이터 저장소 역할(서버 대신 임시로 사용할 배열임)
    private var users: [UserModel] = []
    
    // 생성자에서 기본 MockData 세팅
    init() {
        let names: [String] = ["이유현", "유재혁", "권채은", "김우현", "김나임", "김민규"]
        let parts: [String] = ["iOS", "iOS", "Web", "Web", "Server", "Server"]

        var newUserList: [UserModel] = []

        for i in 0..<names.count {
            let newUser = UserModel(name: names[i], part: parts[i])
            newUserList.append(newUser)
        }

        self.users = newUserList
    }
    
    func fetchUsers() -> [UserModel] {
        return users
    }
    
    func addUser(_ newUser: UserModel) {
        users.append(newUser)
    }
}

