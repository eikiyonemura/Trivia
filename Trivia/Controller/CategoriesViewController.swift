//
//  CategoriesViewController.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 25/06/22.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    var categories: [Category] = [] {
        didSet{
            categoriesTableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Categories"

        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let categoriesService = CategoriesService()
        categoriesService.getCategories { categorie in
            self.categories = categorie
            self.categories.sort { $0.name < $1.name }
        }
    }

}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        categoriesTableView.deselectRow(at: indexPath, animated: true)
        
        let questionVC = QuestionViewController()
        questionVC.id = categories[indexPath.row].id
        questionVC.name = categories[indexPath.row].name
        navigationController?.pushViewController(questionVC, animated: true)
    }
    
}
