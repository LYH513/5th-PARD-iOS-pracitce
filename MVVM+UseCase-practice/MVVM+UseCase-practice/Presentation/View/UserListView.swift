//
//  UserListView.swift
//  5th-SwiftUI-MVVM
//
//  Created by 이유현 on 3/1/25.
//

import SwiftUI

struct UserListView: View {
    @State private var userViewModel: UserViewModel
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
    }
    
    @State private var textField: String = ""
    
    @State private var showSheet: Bool = false
    @State private var name: String = ""
    @State private var part: String = ""
    
    var body: some View {
        NavigationStack{
            
            HStack(spacing:0){
                TextField("이름 검색", text: $textField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action:{
                    userViewModel.getUserList(textField)
                }){
                    Text("검색")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
            List{
                ForEach(userViewModel.userList){ user in
                    VStack(alignment: .leading , spacing: 0){
                        Text(user.name)
                            .font(.title)
                            .foregroundStyle(userViewModel.hightLightiOSPart(user.part))
                            .bold()
                        Text(user.part)
                            .font(.title2)
                            .foregroundStyle(userViewModel.hightLightiOSPart(user.part))
                    } // : VStack
                } // : loop
            } // :List
            .listStyle(.plain)
            .background(.white)
            .sheet(isPresented: $showSheet, content: {
                SheetAddUserView(
                    showSheet: $showSheet,
                    addNewUser : { name, part in
                        userViewModel.addUser(name: name, part: part)
                    }
                )
            })
            
            .navigationTitle("파드 5기 개발 파트장단")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("추가"){
                showSheet = true
            })
            .onAppear{
                userViewModel.getUserList("")
            }
            
        } // : NavigationStack
    }
    
}

#Preview {
    
    // repository
    let repository = UserRepositoryImpl()
    
    // useCase
    let getUserListUseCaseImpl = GetUserListUseCaseImpl(repository: repository)
    let addUserUseCaseImpl = AddUserUseCaseImpl(repository: repository)
    
    //ViewModel
    let viewModel = UserViewModel(getUserListUseCase:getUserListUseCaseImpl , addUserUseCase: addUserUseCaseImpl)
    
    UserListView(userViewModel: viewModel)
}
