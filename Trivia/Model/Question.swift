//
//  Question.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 26/06/22.
//

struct Question: Codable {
    let question: String
    let type: String
    let correct_answer: String
    let incorrect_answers: [String]
}
