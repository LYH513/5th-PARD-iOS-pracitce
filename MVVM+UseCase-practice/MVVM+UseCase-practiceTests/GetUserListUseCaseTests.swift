//
//  GetUserListUseCaseTests.swift
//  MVVM+UseCase-practiceTests
//
//  Created by 이유현 on 4/7/25.
//

import XCTest
@testable import MVVM_UseCase_practice

final class GetUserListUseCaseTests: XCTestCase {
    
    // 테스트에 사용될 Mock repository와 useCase
    var mockRepository: UserRepository!
    var useCase: GetUserListUseCase!
    
    // 각 테스트 전에 초기화
    override func setUpWithError() throws {
        mockRepository = MockUserRepositoryImpl()
        useCase = GetUserListUseCaseImpl(repository: mockRepository)
        
        // 기본값 추가
        mockRepository.addUser(UserModel(name: "이유현", part: "iOS"))
        mockRepository.addUser(UserModel(name: "김나임", part: "server"))
        mockRepository.addUser(UserModel(name: "권채은", part: "web"))
    }
    
    // 각 테스트 후 정리
    override func tearDownWithError() throws {
            mockRepository = nil
            useCase = nil
    }
    
    // ✅ 테스트 1: 검색어가 비어있을 때 전체 유저를 반환해야 함
    func test_execute_whenSearchTextIsEmpty_shouldReturnAllUsers() {
        let result = useCase.execute("")
        XCTAssertEqual(result.count, 3, "검색어가 없을 때는 모든 유저가 반환되어야 합니다.")
    }
    
    // ✅ 테스트 2: 검색어에 해당하는 유저만 반환되어야 함
    func test_execute_whenSearchTextMatchesOneUser_shouldReturnFilteredUser() {
        let result = useCase.execute("유현")
        XCTAssertEqual(result.count, 1, "이름에 '유현'이 포함된 유저만 반환되어야 합니다.")
        XCTAssertEqual(result.first?.name, "이유현")
    }

    // ✅ 테스트 3: 검색어에 해당하는 유저가 없으면 빈 배열 반환
    func test_execute_whenSearchTextMatchesNoUser_shouldReturnEmptyList() {
        let result = useCase.execute("홍길동")
        XCTAssertTrue(result.isEmpty, "검색어와 일치하는 유저가 없을 경우 빈 배열이 반환되어야 합니다.")
    }
}
