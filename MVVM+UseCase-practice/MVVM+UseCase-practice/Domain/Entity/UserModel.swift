//
//  UserModel.swift
//  5th-SwiftUI-MVVM
//
//  Created by 이유현 on 3/1/25.
//

import Foundation

struct UserModel : Identifiable {
    let id = UUID().uuidString
    let name : String
    let part : String
}
