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
    
    // 초기 데이터 세팅 가능하게 하기
    // 테스트용으로 데이터를 초기화하거나 조화하기 위한 역할
    // users에 직접 접근하는 것은 X
    var mockUser: [UserModel] {
            get { users } // 외부에서 값을 읽을 때 users 값 반환
            set { users = newValue } // 외부에서 값을 넣으면 users에 할당
    }
    
    func fetchUsers() -> [UserModel] {
        return users
    }
    
    func addUser(_ newUser: UserModel) {
        users.append(newUser)
    }
}
