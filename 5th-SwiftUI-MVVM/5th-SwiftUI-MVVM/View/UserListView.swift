//
//  UserListView.swift
//  5th-SwiftUI-MVVM
//
//  Created by 이유현 on 3/1/25.
//

import SwiftUI

struct UserListView: View {
    @State private var userViewModel = UserViewModel()
    
    @State private var textField: String = ""
    
    @State private var name: String = ""
    @State private var part: String = ""
    
    var body: some View {
        NavigationStack{
            
            HStack(spacing:0){
                TextField("이름 검색", text: $textField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action:{
                    userViewModel.filterSearchList(textField)
                }){
                    Text("검색")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
            List{
                ForEach(userViewModel.filteredUserList){ user in
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
            .sheet(isPresented: $userViewModel.showSheet, content: {
                SheetAddUserView(
                    showSheet: $userViewModel.showSheet,
                    addNewUser : { name, part in
                        userViewModel.addNewUser(name: name, part: part)
                    }
                )
            })
            
            .navigationTitle("파드 5기 개발 파트장단")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("추가"){
                userViewModel.toggleSheet()
            })
            
        } // : NavigationStack
    }
    
}

extension UserViewModel {
    func hightLightiOSPart(_ part: String) -> Color {
        return part == "iOS" ? Color.cyan : Color.black
    }
}

#Preview {
    UserListView()
}
