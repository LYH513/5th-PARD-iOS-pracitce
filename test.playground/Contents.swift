import Foundation

var subDic2 = ["a": 10, "b": 20, "c": 30]

import SwiftData

@Model
class BookReivewModel {
    var title : String
    var author : String
    var review : String
    
    init(title: String, author: String, review: String) {
        self.title = title
        self.author = author
        self.review = review
    }
}



func getUserData() async {
    // 코드 작성
}


await getUserData()



struct UserModel : Encodable , Decodable {
    let name: String
    let job : String
}


