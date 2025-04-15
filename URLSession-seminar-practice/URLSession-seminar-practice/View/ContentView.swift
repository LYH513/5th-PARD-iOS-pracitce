//
//  ContentView.swift
//  URLSession-seminar-practice
//
//  Created by 이유현 on 3/3/25.
//

import SwiftUI

//MARK: - Model
struct UserModel : Codable, Hashable {
    let id: String?
    let name: String
    let job : String
}

//MARK: - error type
enum ErrorType : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

//MARK: - UI
struct ContentView: View {
    
    // 1. 서버 주소
    private let baseURL: String = "https://67c4a5d2c4649b9551b4380e.mockapi.io/user"
    
    @State private var userList: [UserModel] = []
    
    @State private var editUser: UserModel? = nil
    
    @State private var buttonMode: String = "추가"
    @State private var name: String = ""
    @State private var job: String = ""
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                
                HStack{
                    Text("이름:")
                        .padding(.leading, 15)
                    
                    TextField("이름을 입력하세요", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                }
                
                HStack{
                    Text("직업:")
                        .padding(.leading, 15)
                    
                    TextField("직업을 입력하세요", text: $job)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                }
                
                Button(action:{
                    //post
                    Task{
                        if let user = editUser,
                           let id = user.id
                        {
                            await updateUser(id: id, name: name, job: job)
                            userList = try await getUserList()
                        } else {
                            await postUser(name: name, job: job)
                            userList = try await getUserList()
                        }
                        
                        editUser = nil
                        buttonMode = "추가"
                        name = ""
                        job = ""
                        
                    }
                    
                }){
                    Text(buttonMode)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(buttonMode == "확인" ? .yellow : .blue)
                .padding()
                
                List{
                    ForEach(userList, id: \.self) { user in
                        HStack{
                            Text(user.name)
                                .font(.title2).bold()
                            
                            Text(user.job)
                                .font(.body)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                // delete
                                Task{
                                    if let id = user.id {
                                        await deleteUser(id: id)
                                    }
                                    userList = try await getUserList()
                                }
                            } label: {
                                Text("삭제")
                            }
                            .tint(.red)
                        } // : swipeActions
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                Task{
                                    // update
                                    editUser = user
                                    buttonMode = "확인"
                                    name = user.name
                                    job = user.job
                                }
                            } label: {
                                Text("수정")
                            }
                            .tint(.yellow)
                        } // : swipeActions
                    }
                } // : List
            } // : VStack
            .task {
                do{
                    userList = try await getUserList()
                } catch {
                    print("Get Error: \(error)")
                }
                
            }
            .navigationTitle("URLSession 실습")
            .navigationBarTitleDisplayMode(.inline)
        } // : NavigationStack
    }
    
    //MARK: - API Function
    //MARK: - get
    private func getUserList() async throws -> [UserModel] {
        // 2. URL 만들기
        guard let url = URL(string: "\(baseURL)") else {
            throw ErrorType.invalidURL
        }
        
        // 3. URLSession 구성 및 URLSession Task를 만든 후 네트워크 요청
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // 서버로부터 데이터를 받아오는데 실패하면 error를 던지고 함수가 종료됨
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ErrorType.invalidResponse
        }
        
        // 데이터를 성공적으로 받아왔을 경우 do-catch문 실행
        do {
            //UserModel의 배열 형태로 디코딩하여 결과값을 반환함
            let decoder = JSONDecoder()
            let data = try decoder.decode([UserModel].self, from: data)
            print(data)
            
            return data
        }
        catch {
            throw ErrorType.invalidData
        }
    }
    
    //MARK: - post
    private func postUser(name: String, job: String) async {
        // 1. URL 만들기
        guard let url = URL(string: "\(baseURL)") else {
            print("invalidURL")
            return
        }
        
        // 2. 새로운 데이터 생성
        let newUser = UserModel(id: nil , name: name, job: job)
        
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
            print("Encodin error: \(error)")
            return
        }
        
        // 4. URLSession 구성 및 URLSession Task를 만든 후 네트워크 요청
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            // 서버로부터 데이터를 받아오는데 실패하면 error를 던지고 함수가 종료됨
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("error: \(response)")
                return
            }
            
        } catch {
            print("Network error: \(error)")
        }
    }
    
    //MARK: - delete
    private func deleteUser(id: String) async {
        // 1. URL 만들기
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            print("invalidURL")
            return
        }
        
        // 2. get이 아닌 경우 URLRequest 객체를 생성하기
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        // 3. URLSession 구성 및 URLSession Task를 만든 후 네트워크 요청
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            // 서버로부터 데이터를 받아오는데 실패하면 error를 던지고 함수가 종료됨
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("error: \(response)")
                return
            }
            
        } catch {
            print("Network error: \(error)")
        }
    }
    
    //MARK: - Put
    private func updateUser(id: String, name: String, job: String) async {
        // 1. URL 만들기
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            print("invalidURL")
            return
        }
        
        print("id: \(id) / name: \(name) / job: \(job)")
        // 2. 업데이트할 데이터 생성 - 이름만 바꾸려고해도 put이기 때문에 , age 다 넣어서 보내야함
        let updateUser = UserModel(id: id, name: name, job: job)
        
        
        // 3. get이 아닌 경우 URLRequest 객체를 생성하기
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // 서버에서 json 형태로 데이터를 받기 때문에 우리도 struct로 만들어 놓은 데이터 형태를
            //json 형태로 만들어 줄 필요가 있음. 그래서 쓰는게 JSONEncoder
            //JSONEncoder는 newUser 데이터를 json형태로 만들어 준다는 의미임!
            request.httpBody = try JSONEncoder().encode(updateUser)
        } catch {
            print("Encodin error: \(error)")
            return
        }
        
        // 4. URLSession 구성 및 URLSession Task를 만든 후 네트워크 요청
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            // 서버로부터 데이터를 받아오는데 실패하면 error를 던지고 함수가 종료됨
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("error: \(response)")
                return
            }
            
        } catch {
            print("Network error: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
