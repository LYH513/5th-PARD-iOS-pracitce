//
//  MockUserRepositoryImpl.swift
//  MVVM+UseCase-practice
//
//  Created by 이유현 on 4/1/25.
//

import Foundation

/*
UserRepository 를 준수하는 Mock repository를 만들어 개발 환경에서는 mock repository를 쓰고, 실제 배포를 할 때는 서버와 연결된 repository를 사용할 수 있음.
 => 코드를 바꿔 끼우기 쉽고, 테스트할 때 용의하며, 서버 통신이 되지 않는 상황에서도 화면을 실행시킬 수 있음
*/

final class MockUserRepositoryImpl : UserRepository {
    
    private var users: [UserModel] = []
    
    func fetchUsers() -> [UserModel] {
        return users
    }
    
    func addUser(_ newUser: UserModel) {
        print("새로운 유저가 추가됐습니다.")
        users.append(newUser)
    }
    
}
