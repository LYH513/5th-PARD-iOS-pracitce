//
//  AddUserUseCaseTests.swift
//  MVVM+UseCase-practiceTests
//
//  Created by 이유현 on 4/7/25.
//

import XCTest
@testable import MVVM_UseCase_practice

final class AddUserUseCaseTests: XCTestCase {

    // 테스트에 사용될 Mock repository와 useCase
    var mockRepository: UserRepository!
    var useCase: AddUserUseCase!
    
    // 각 테스트 전에 초기화
    override func setUpWithError() throws {
        mockRepository = MockUserRepositoryImpl()
        useCase = AddUserUseCaseImpl(repository: mockRepository)
    }
    
    // 각 테스트 후 정리
    override func tearDownWithError() throws {
            mockRepository = nil
            useCase = nil
    }

    // ✅ 테스트 1: 이름은 있지만 파트가 비어 있을 때 유저가 추가되지 않아야 함
    func test_addUser_whenPartIsMissing_shouldNotAddUser() {
        // given: 이름은 있고, 파트는 빈 문자열
        let name = "John"
        let part = ""

        // when: useCase 실행
        useCase.execute(name: name, part: part)

        // then: addUser가 호출되지 않았는지 확인
        // 메시지는 테스트에 실패했을 경우 출력된다!
        XCTAssertTrue(mockRepository.fetchUsers().isEmpty, "파트가 없을 때는 유저가 추가되지 않아야 합니다.")
    }
    
    // ✅ 테스트 2: 파트는 있지만 이름이 비어 있을 때 유저가 추가되지 않아야 함
    func test_addUser_whenNameIsMissing_shouldNotAddUser() {
        // given: 이름은 빈 문자열, 파트는 유효함
        let name = ""
        let part = "iOS"

        // when: useCase 실행
        useCase.execute(name: name, part: part)

        // then: addUser가 호출되지 않았는지 확인
        XCTAssertTrue(mockRepository.fetchUsers().isEmpty, "이름이 없을 때는 유저가 추가되지 않아야 합니다.")
    }
    
    // ✅ 테스트 3: 이름과 파트가 모두 있을 때 유저가 정상적으로 추가되어야 함
    func test_addUser_whenNameAndPartAreValid_shouldAddUser() {
        // given: 유효한 이름과 파트
        let name = "Jane"
        let part = "Design"

        // when: useCase 실행
        useCase.execute(name: name, part: part)

        // then: 유저가 추가되었는지 확인
        XCTAssertEqual(mockRepository.fetchUsers().count, 1, "유효한 입력일 경우 유저가 추가되어야 합니다.")

        // 추가된 유저의 정보도 확인
        let addedUser = mockRepository.fetchUsers().first
        XCTAssertEqual(addedUser?.name, name, "추가된 유저의 이름이 일치해야 합니다.")
        XCTAssertEqual(addedUser?.part, part, "추가된 유저의 파트가 일치해야 합니다.")
    }

}
