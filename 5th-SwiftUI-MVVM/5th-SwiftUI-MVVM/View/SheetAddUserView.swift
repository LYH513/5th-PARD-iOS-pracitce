//
//  SheetAddUserView.swift
//  5th-SwiftUI-MVVM
//
//  Created by 이유현 on 3/1/25.
//

import SwiftUI

struct SheetAddUserView: View {
    @Binding var showSheet: Bool
    @State private var name: String = ""
    @State private var part: String = ""
    var addNewUser: (String, String) -> Void
    
    var body: some View {
        VStack(spacing:0){
            
            Text("새로운 파트장단 추가")
                .font(.title2).bold()
                .padding(.top, 20)
            
            TextField("이름을 입력하새요", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("파트를 입력하새요", text: $part)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action:{
                showSheet = false
                addNewUser(name, part)
            }){
                Text("확인")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}
