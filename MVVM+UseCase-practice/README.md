### MVVM + UseCase

#### 프로젝트 폴더 구조

- **Domain**
  - Entity
    - UserModel.swift  
  - UseCase
    - UseCase  (protocol)
      - AddUserUseCase.swift
      - GetUserListUseCase.swift
    - UseCase  (implement)
      - AddUserUseCaseImpl.swift
      - GetUserListUseCaseImpl.swift
  - Repository (protocol)
    - UserRepository.swift
- **Data**
  - Repository (implement)
    - UserRepositoryImpl.swift  
- **Presentation**
  - ViewModel
    - UserViewModel.swift 
  - View (SwiftUI)
    - SheetAddUserView.swift
    - UserListView.swift


#### 역할
  - ✅ 비즈니스 로직(필터링, 정렬, 계산 등) 은 UseCase에만 위치
  - ✅ ViewModel은 데이터 흐름 연결 및 UI에 보여줄 데이터 형태로 가공
  - ✅ Repository는 데이터 소스 제공 역할 (네트워크, DB, 캐시 등)

#### 흐름 정리
  - View는 ViewModel을 감시하고,
  - ViewModel은 UseCase를 호출하고,
  - UseCase는 Repository를 통해 데이터를 가져온다.
  - Repository는 실제 데이터를 제공한다. (여기서는 서버통신 없이 로컬 데이터)

    ##### 그리고, APP에서 DI(의존성 주입)을 해준다
        - App 진입점에서 DI를 수행하는 이유는?
          객체 간 연결을 외부에서 관리해서 느슨한 연결을 유지하고, 교체나 테스트가 쉬워짐!

#### 흐름 보기
    - View → ViewModel → UseCase → Repository → Entity
 
#### 장점
  - 이 구조는 서버 통신을 나중에 추가하고 싶을 때 RepositoryImpl만 바꾸면 되기 때문에 유연하게 확장이 가능하다

---

#### UseCase
- UseCase는 단일 책임 원칙(SRP) 에 따라 나누는 게 일반적이다.
  - 각 유스케이스는 하나의 비즈니스 동작을 처리하는 단위
  - 보통 Get, Add, Update, Delete 는 각각 별도의 UseCase로 분리
- UseCase를 나누는 이유
  1. 단일 책임을 명확하게 해서 유지 보수가 쉬워짐
  2. 테스트가 깔끔해지고, 특정 기능만 수정해도 다른 UseCase에 영향이 없음
  3. 나중에 각각의 기능에 대해 비즈니스 로직이 복잡해져도 확장하기 쉬움
