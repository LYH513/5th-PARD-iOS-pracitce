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
    var filteredUserList : [UserModel] = []
    var showSectionType : SectionType = .emptyData
    
    
    init() {
        userList = getMemoMockData()
        filterSearchList("")
    }
    
    //MARK: - View에게 데이터를 제공하는 로직 (View와 관련된 로직만)
    
    // 검색한 데이터의 개수에 따라
    func decideSectionType(){
        if filteredUserList.count == 0 {
            showSectionType = .emptyData
        }
        else if filteredUserList.count == 1 {
            showSectionType = .onlyOneData
        }
        else {
            showSectionType = .twoMore(dataNum: filteredUserList.count)
        }
    }
    
    //MARK: - 비지니스 로직 (View와 관련 X)
    
    // 초기에 화면에 보여줄 MockData를 설정함
    private func getMemoMockData() -> [UserModel]{
        let names : [String] = ["이유현", "유재혁", "권채은", "김우현", "김나임", "김민규"]
        let parts : [String] = ["iOS","iOS", "Web", "Web", "Server", "Server"]
        
        var newUserList : [UserModel] = []
        for i in 0...5 {
            let newUser = UserModel(name: names[i], part: parts[i])
            newUserList.append(newUser)
        }
        
        return newUserList
    }
    
    // 검색 결과 filtering
    func filterSearchList(_ searchText: String){
        if searchText.isEmpty {
            filteredUserList = userList
        } else {
            filteredUserList = userList.filter{ $0.name.contains(searchText) }
        }
        
        decideSectionType()
    }
    
    // 새로운 유저 추가
    func addNewUser(name: String, part: String) {
        if !name.isEmpty && !part.isEmpty {
            let newUser = UserModel(name: name, part: part)
            userList.append(newUser)
            filteredUserList = userList
        }
    }
        
}
