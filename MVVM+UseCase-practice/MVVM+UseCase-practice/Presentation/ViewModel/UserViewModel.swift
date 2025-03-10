//
//  UserViewModel.swift
//  5th-SwiftUI-MVVM
//
//  Created by 이유현 on 3/1/25.
//

import Foundation
import Observation

enum SectionType {
    case emptyData // 데이터가 아무것도 없을 때
    case onlyOneData // 데이터가 1개뿐일 때
    case twoMore(dataNum: Int) //데이터가 2개 이상일 때
}

@Observable
final class UserViewModel {
    var userList : [UserModel] = []
    var showSectionType : SectionType = .emptyData
    
    private let getUserListUseCase: GetUserListUseCase
    private let addUserUseCase: AddUserUseCase
    
    init(getUserListUseCase: GetUserListUseCase, addUserUseCase: AddUserUseCase) {
        self.getUserListUseCase = getUserListUseCase
        self.addUserUseCase = addUserUseCase
    }
    
    //MARK: - View에게 데이터를 제공하는 로직 (View와 관련된 로직만)
    
    // 검색한 데이터의 개수에 따라 보여지는 섹션이 달라지도록 하는 함수
    func decideSectionType(){
        if userList.count == 0 {
            showSectionType = .emptyData
        }
        else if userList.count == 1 {
            showSectionType = .onlyOneData
        }
        else {
            showSectionType = .twoMore(dataNum: userList.count)
        }
    }
    
    // 검색어에 따라 유저 불러오기 (전체 / 검색 필터링)
    func getUserList(_ searchText: String){
        let users = getUserListUseCase.execute(searchText)
        self.userList = users
        decideSectionType()
    }
    
    // 유저 추가
    func addUser(name: String, part: String){
        addUserUseCase.execute(name: name, part: part)
        getUserList("") // 전체 유저 다시 불러오기
    }
        
}
