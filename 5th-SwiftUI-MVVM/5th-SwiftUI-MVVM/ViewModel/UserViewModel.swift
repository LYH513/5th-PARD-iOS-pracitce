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
    var userList: [UserModel] = []
    var filteredUserList: [UserModel] = []
    var showSheet: Bool = false
    
    init() {
        userList = getMemoMockData()
        filterSearchList("")
    }
    
    //MARK: - View에게 가공된 데이터를 제공하는 로직 (View와 관련된 로직만)
    func toggleSheet(){
        showSheet.toggle()
    }
    
    //MARK: - 비지니스 로직 (View와 관련 X)
    
    // 초기에 화면에 보여줄 MockData를 설정함
    private func getMemoMockData() -> [UserModel]{
        let names : [String] = ["유재혁", "이유현", "권채은", "김우현", "김나임", "김민규"]
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
