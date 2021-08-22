//
//  UserModel.swift
//  FaceAnswer
//
//  Created by Şafak Can Baş on 19.08.2021.
//

import Foundation

class UserModel: Codable {
    var username:String
    var score: String
    
    init(username:String, score: String) {
        self.username = username
        self.score = score
    }
}

class TempUserModel {
    static let shared = TempUserModel()
    var tempUsername: String?
}
