//
//  UserListView.swift
//  URLSession-Swagger-Practice
//
//  Created by 이유현 on 3/13/25.
//

import SwiftUI

//MARK: - Model
struct UserModel : Codable, Hashable {
    var id: Int?
    let name: String
    let age: Int
    let part: String
}

//MARK: - error type
enum ErrorType : Error {
    case invalidURL
    case invalidResponse
    case networkError
}

//서버주소
enum BaseURL : String {
    case baseUrl = "http://172.17.198.87:8080"
}

//MARK: - View
struct UserListView: View {
    
    @State private var userList: [UserModel] = []
    @State private var showSheet: Bool = false
    
    @State private var searchTextField: String = ""
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                
                HStack{
                    
                    TextField("파트 조회하기", text: $searchTextField)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    Button(action: {
                        Task{
                            // all / iOS / web / server
                            do{
                                if searchTextField == "" {
                                    userList = try await getUserList()
                                }
                                else {
                                    userList = try await getUserList(searchTextField)
                                }
                            } catch {
                                print("❌ Get Error: \(error)")
                            }
                        }
                    }){
                        Text("검색")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                
                List{
                    ForEach(userList, id: \.self) { user in
                        NavigationLink{
                            UserSheetView(user: user, showSheet: $showSheet)
                        } label: {
                            HStack{
                                Text(user.name)
                                    .font(.title2).bold()
                                
                                Text(String(user.age))
                                    .font(.body)
                                
                                Text(user.part)
                                    .font(.body)
                            }
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
                    }
                } // : List
            } // : VStack
            .task {
                do{
                    userList = try await getUserList()
                } catch {
                    print("❌ Get Error: \(error)")
                }
                
            }
            .navigationTitle("URLSession 실습")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action : {showSheet = true}){
                Text("추가")
            }
            )
            .sheet(isPresented: $showSheet) {
                UserSheetView(showSheet: $showSheet)
            }
            .onChange(of: showSheet) {
                Task{
                    userList = try await getUserList()
                }
            }
        }
    } // : NavigationStack
}

//MARK: - get
private func getUserList(_ search: String = "all") async throws -> [UserModel] {
    // 1. URL 만들기
    let urlString = BaseURL.baseUrl.rawValue
    guard let url = URL(string: "\(urlString)/user?part=\(search)") else {
        throw ErrorType.invalidURL
    }
    
    // 2. URLSession 구성 및 URLSession Task를 만든 후 네트워크 요청
    let (data, response) = try await URLSession.shared.data(from: url)
    
    // 서버로부터 데이터를 받아오는데 실패하면 error를 던지고 함수가 종료됨
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        throw ErrorType.invalidResponse
    }
    
    // 데이터를 성공적으로 받아왔을 경우 do-catch문 실행
    do {
        //UserModel의 배열 형태로 디코딩하여 결과값을 반환함
        let data = try JSONDecoder().decode([UserModel].self, from: data)
        
        return data
    }
    catch {
        throw ErrorType.networkError
    }
}

//MARK: - delete
private func deleteUser(id: Int) async {
    // 1. URL 만들기
    let urlString = BaseURL.baseUrl.rawValue
    guard let url = URL(string: "\(urlString)/user/\(id)") else {
        print("❌ invalidURL")
        return
    }
    
    // 2. get이 아닌 경우 URLRequest 객체를 생성하기
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    // 3. URLSession 구성 및 URLSession Task를 만든 후 네트워크 요청
    do {
        let (_, response) = try await URLSession.shared.data(for: request)
        
        // 서버로부터 데이터를 받아오는데 실패하면 error를 print하고 함수가 종료됨
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("❌ error: \(response)")
            return
        }
        
    } catch {
        print("❌ Network error: \(error)")
    }
}


#Preview {
    UserListView()
}
