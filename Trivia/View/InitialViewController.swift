//
//  InitialViewController.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 25/06/22.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        let informationVC = InformationViewController()
        present(informationVC, animated: true)
    }
    
    @IBAction func inicioButtonTapped(_ sender: UIButton) {
        guard let text = userTextField.text, !text.isEmpty else {
            let ac = UIAlertController(title: "Erro", message: "O campo usuário não pode esta vazio", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: .none))
            present(ac, animated: true)
            return
        }
        
        let tabBarController = TabBarController()
        //let navigationController =  UINavigationController(rootViewController: tabBarController)
        
//        let categoriesVC =  CategoriesViewController()
//        let navigationController = UINavigationController(rootViewController: categoriesVC)
        tabBarController.modalPresentationStyle = .overFullScreen
        present(tabBarController, animated: true)
        

    }    

}
