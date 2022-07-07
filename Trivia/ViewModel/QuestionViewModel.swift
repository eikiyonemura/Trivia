//
//  QuestionViewModel.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 07/07/22.
//

import Foundation

final class QuestionViewModel {
    private let questionService: QuestionService
    
    init(questionService: QuestionService) {
        self.questionService = questionService
    }
    
    var questions = [Question]()
    var currentIndex = 0
    
    func getQuestions(for categoryID: Int, completion: @escaping() -> Void) {
        questionService.getQuestions(category: categoryID) { [weak self] questions in
            self?.questions = questions
            completion()
        }
    }
}
