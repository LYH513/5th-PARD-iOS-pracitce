//
//  UserSheetView.swift
//  URLSession-Swagger-Practice
//
//  Created by 이유현 on 3/13/25.
//

import Foundation
import SwiftUI

struct UserSheetView : View {
    
    @Environment(\.dismiss) private var dismiss
    
    var user: UserModel? = nil
    
    var isNewUser: Bool {
        self.user == nil ? true : false
    }
    
    @Binding var showSheet: Bool
    @State var name: String = ""
    @State var age: String = ""
    @State var part: String = ""
    
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack{
            
            Text(isNewUser ? "새로운 멤버 추가하기" : "기존 멤버 수정하기")
                .font(.largeTitle).bold()
                .padding()
            
            HStack{
                Text("이름:")
                    .padding(.leading, 15)
                
                TextField("이름을 입력하세요", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            
            HStack{
                Text("나이:")
                    .padding(.leading, 15)
                
                TextField("나이를 입력하세요", text: $age)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
            }
            
            HStack{
                Text("파트:")
                    .padding(.leading, 15)
                
                TextField("파트를 입력하세요", text: $part)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            
            
            // 에러 메시지
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            
            Button(action:{
                //post
                if name.isEmpty || age.isEmpty || part.isEmpty {
                    errorMessage = "모든 항목을 입력해주세요."
                }else {
                    errorMessage = ""  // 에러 메시지 초기화
                    
                    Task {
                        if isNewUser {
                            //추가
                            let newUser = UserModel(name: name, age: Int(age) ?? 0, part: part)
                            await postUser(data: newUser)
                            showSheet = false
                            
                        } else {
                            // 수정
                            let newUser = UserModel(name: name, age: Int(age) ?? 0, part: part)
                            if let id = user?.id {
                                await updateUser(id: id, data: newUser)
                            }
                            
                            dismiss()
                        }
                    } // Task
                    
                }
                
            }){
                Text(isNewUser ? "추가" : "수정")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Spacer()
            
        } // VStack
        .onAppear {
            if let user = user {
                name = user.name
                age = String(user.age)
                part = user.part
            }
        }
    }
    
    //MARK: - post
    private func postUser(data: UserModel) async {
        // 1. URL 만들기
        let urlString = BaseURL.baseUrl.rawValue
        guard let url = URL(string: "\(urlString)/user") else {
            print("❌ invalidURL")
            return
        }
        
        // 2. 새로운 데이터 생성
        let newUser = UserModel(id: nil, name: data.name , age: data.age, part: data.part)
        
        // 3. get이 아닌 경우 URLRequest 객체를 생성하기
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // 서버에서 json 형태로 데이터를 받기 때문에 우리도 struct로 만들어 놓은 데이터 형태를
            //json 형태로 만들어 줄 필요가 있음. 그래서 쓰는게 JSONEncoder
            //JSONEncoder는 newUser 데이터를 json형태로 만들어 준다는 의미임!
            request.httpBody = try JSONEncoder().encode(newUser)
        } catch {
            print("❌ Encodin error: \(error)")
            return
        }
        
        // 4. URLSession 구성 및 URLSession Task를 만든 후 네트워크 요청
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            // 서버로부터 데이터를 받아오는데 실패하면 error를 던지고 함수가 종료됨
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("❌ error: \(response)")
                return
            }
            
        } catch {
            print("❌ Network error: \(error)")
        }
    }
    
    //MARK: - PATCH
    private func updateUser(id: Int, data: UserModel) async {
        // 1. URL 만들기
        let urlString = BaseURL.baseUrl.rawValue
        guard let url = URL(string: "\(urlString)/user/\(id)") else {
            print("❌ invalidURL")
            return
        }
        
        // 2. 업데이트할 데이터 생성 - 이름만 바꾸려고해도 put이기 때문에 , age 다 넣어서 보내야함
        let updateUser = UserModel(id: nil, name: data.name, age: data.age , part: data.part)
        
        
        // 3. get이 아닌 경우 URLRequest 객체를 생성하기
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            // 서버에서 json 형태로 데이터를 받기 때문에 우리도 struct로 만들어 놓은 데이터 형태를
            //json 형태로 만들어 줄 필요가 있음. 그래서 쓰는게 JSONEncoder
            //JSONEncoder는 newUser 데이터를 json형태로 만들어 준다는 의미임!
            request.httpBody = try JSONEncoder().encode(updateUser)
        } catch {
            print("❌ Encodin error: \(error)")
            return
        }
        
        // 4. URLSession 구성 및 URLSession Task를 만든 후 네트워크 요청
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            // 서버로부터 데이터를 받아오는데 실패하면 error를 던지고 함수가 종료됨
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("❌ error: \(response)")
                return
            }
            
        } catch {
            print("❌ Network error: \(error)")
        }
    }
}
