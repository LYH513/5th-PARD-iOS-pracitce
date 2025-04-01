//
//  UserViewModel.swift
//  5th-SwiftUI-MVVM
//
//  Created by 이유현 on 3/1/25.
//

import Foundation
import Observation
import SwiftUICore

@Observable
final class UserViewModel {
    var userList : [UserModel] = []
    
    private let getUserListUseCase: GetUserListUseCase
    private let addUserUseCase: AddUserUseCase
    
    init(getUserListUseCase: GetUserListUseCase, addUserUseCase: AddUserUseCase) {
        self.getUserListUseCase = getUserListUseCase
        self.addUserUseCase = addUserUseCase
    }
    
    //MARK: - View에게 데이터를 제공하는 로직 (View와 관련된 로직만)
    
    // iOS 파트만 색상 하이라이트
    func hightLightiOSPart(_ part: String) -> Color {
        return part == "iOS" ? Color.cyan : Color.black
    }
    
    // 검색어에 따라 유저 불러오기 (전체 / 검색 필터링)
    func getUserList(_ searchText: String){
        let users = getUserListUseCase.execute(searchText)
        self.userList = users
    }
    
    // 유저 추가
    func addUser(name: String, part: String){
        addUserUseCase.execute(name: name, part: part)
        getUserList("") // 전체 유저 다시 불러오기
    }
        
}
