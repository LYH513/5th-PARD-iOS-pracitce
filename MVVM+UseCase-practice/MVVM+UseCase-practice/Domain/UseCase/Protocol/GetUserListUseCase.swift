//
//  GetUserListUseCase.swift
//  MVVM+UseCase-practice
//
//  Created by 이유현 on 3/10/25.
//

import Foundation


protocol GetUserListUseCase {
    func execute(_ searchText: String) -> [UserModel]
}
