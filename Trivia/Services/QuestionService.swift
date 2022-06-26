//
//  QuestionService.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 26/06/22.
//

import Foundation
import Alamofire

class QuestionService {
    private struct Results: Codable {
        let results: [Question]
    }
    let apiClient = AlamofireAPIClient()
    
    func getQuestions(category: Int, completion: @escaping ([Question]) -> Void) {
        let categoriesURL = category != 0 ? "https://opentdb.com/api.php?amount=10&category=\(category)" : "https://opentdb.com/api.php?amount=10"
        apiClient.get(url: categoriesURL) { response in
            switch response {
            case.success(let data):
                do {
                    if let data = data {
                        let result = try JSONDecoder().decode(Results.self, from: data)
                        completion(result.results)
                    }
                } catch {
                    completion([])
                }
            case .failure(_):
                completion([])
            }
        }
        print(categoriesURL)
    }
}
