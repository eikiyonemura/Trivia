//
//  CategoriesService.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 26/06/22.
//

import Foundation
import Alamofire

class CategoriesService {
    private struct Categories: Codable {
        let trivia_categories: [Category]
    }
    let apiClient = AlamofireAPIClient()
    
    func getCategories(completion: @escaping ([Category]) -> Void) {
        let categoriesURL = "https://opentdb.com/api_category.php"
        apiClient.get(url: categoriesURL) { response in
            switch response {
            case.success(let data):
                do {
                    if let data = data {
                        let categories = try JSONDecoder().decode(Categories.self, from: data)
                        completion(categories.trivia_categories)
                    }
                } catch {
                    completion([])
                }
            case .failure(_):
                completion([])
            }
        }
        
    }
}

class AlamofireAPIClient {
    func get(url: String, completion: @escaping (Result<Data?, AFError>) -> Void) {
        AF.request(url).response { response in
            completion(response.result)
        }
    }
}
