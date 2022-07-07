//
//  CategoriesViewModel.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 07/07/22.
//

import Foundation

final class CategoriesViewModel {
    private let categoriesService: CategoriesService
    var categories = [Category]()
    
    init(categoriesService: CategoriesService) {
        self.categoriesService = categoriesService
    }
    
    func getCategories(completion: @escaping () -> Void) {
        categoriesService.getCategories { [weak self] categories in
            self?.categories = categories
            self?.categories.sort { $0.name < $1.name }
            completion()
        }
    }
}
