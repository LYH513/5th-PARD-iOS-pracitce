//
//  UserListView.swift
//  5th-SwiftUI-MVVM
//
//  Created by 이유현 on 3/1/25.
//

import SwiftUI

/*
 실습 1:

 해당 파일은 View와 비지니스 로직이 분리되지 않고 함께 작성된 코드입니다.
 
 따라서, View와 비지니스 로직이 분리하기 위해,
 0. 먼저 코드의 로직이 어떤 식으로 흘러가는지 파악하세요.
 1. MVVM 패턴을 바탕으로 ViewModel을 생성하세요.
 2. View에는 UI와 관련된 코드, ViewModel에는 비지니스 로직이 담긴 코드로 분리하세요.
 3. 기존 로직과 동일하게 실행되는지 확인!
 
*/

struct UserListView: View {
    
    @State private var userList: [UserModel] = []
    @State private var filteredUserList: [UserModel] = []
    @State private var showSheet: Bool = false
    
    @State private var textField: String = ""
    
    @State private var name: String = ""
    @State private var part: String = ""
    
    //MARK: - View
    var body: some View {
        NavigationStack{
            
            HStack(spacing:0){
                TextField("이름 검색", text: $textField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action:{
                    filterSearchList(textField)
                }){
                    Text("검색")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
            List{
                ForEach(filteredUserList){ user in
                    VStack(alignment: .leading , spacing: 0){
                        Text(user.name)
                            .font(.title)
                            .bold()
                        Text(user.part)
                            .font(.title2)
                    } // : VStack
                } // : loop
            } // :List
            .listStyle(.plain)
            .background(.white)
            .sheet(isPresented: $showSheet, content: {
                SheetAddUserView(
                    showSheet: $showSheet,
                    addNewUser : { name, part in
                        addNewUser(name: name, part: part)
                    }
                )
            })
            
            .navigationTitle("파드 5기 개발 파트장단")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("추가"){
                toggleSheet()
            })
            
        } // : NavigationStack
        .onAppear{
            userList = getMemoMockData()
            filteredUserList = userList
        }
    }
    
    //MARK: -Business logic
    
    func toggleSheet(){
        showSheet.toggle()
    }
    
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

#Preview {
    UserListView()
}
