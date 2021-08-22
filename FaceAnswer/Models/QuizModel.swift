//
//  QuizModel.swift
//  FaceAnswer
//
//  Created by Şafak Can Baş on 18.08.2021.
//

import Foundation


struct QuizModelRespose: Codable {
    let results : [QuizModel]
    let respose_code : Int?
}

struct QuizModel : Codable {
    let category : String?
    let difficulty : String?
    let question : String?
    let quesitionareType : String?
    let correctAnswer : String?
    let incorrectAnswers : [String]?
    
    private enum CodingKeys: String, CodingKey {
        case category, difficulty, question, quesitionareType = "type", correctAnswer = "correct_answer", incorrectAnswers = "incorrect_answers"
    }
}
