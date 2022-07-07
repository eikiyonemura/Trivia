//
//  CategoriesViewController.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 25/06/22.
//

import UIKit

class CategoriesViewController: UIViewController {
    
//    var categories: [Category] = [] {
//        didSet{
//            categoriesTableView.reloadData()
//        }
//    }
    
    private var viewModel: CategoriesViewModel?
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CategoriesViewModel(categoriesService: CategoriesService())
        
        navigationItem.title = "Categories"

        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        getCategories()
        

    }
    
    private func getCategories() {
        viewModel?.getCategories(completion: { [weak self] in
            self?.categoriesTableView.reloadData()
        })
    }

}



extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return categories.count
        return viewModel?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = categories[indexPath.row].name
        cell.textLabel?.text = viewModel?.categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        categoriesTableView.deselectRow(at: indexPath, animated: true)
        
        let questionVC = QuestionViewController()
        //questionVC.id = categories[indexPath.row].id
        //questionVC.name = categories[indexPath.row].name
        guard let id =  viewModel?.categories[indexPath.row].id, let name = viewModel?.categories[indexPath.row].name else { return }
        questionVC.id = id
        questionVC.name = name
        navigationController?.pushViewController(questionVC, animated: true)
    }
    
}
