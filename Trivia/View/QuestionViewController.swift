//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 26/06/22.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var id: Int = 0
    var name: String = "Random"
    
    //var questions: [Question] = []
    //var questionIndex = 0
    var score = 0
    
    private var viewModel: QuestionViewModel?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = QuestionViewModel(questionService: QuestionService())
        
        if name == "Random" {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "repeat"), style: .plain, target: self, action: #selector(self.tryAgain))
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        
        answer1.isHidden = true
        answer2.isHidden = true
        answer3.isHidden = true
        answer4.isHidden = true
        trueButton.isHidden = true
        falseButton.isHidden = true

        //guard let name = name else { return }
        navigationItem.title = name
        
        //guard let id = id else { return }
        
        getQuestions(id)
                
    }
    
    @IBAction func muiltipleAnswerButtonPressed(_ sender: UIButton) {
        //if sender.currentTitle == questions[questionIndex].correct_answer {
        guard let currentIndex = viewModel?.currentIndex else { return }
        if sender.currentTitle == viewModel?.questions[currentIndex].correct_answer {
            score += 1
        }
        //questionIndex += 1
        viewModel?.currentIndex += 1
        checkIndex()
        
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let userAnswer = sender.tag == 0 ? "True" : "False"
    
        guard let currentIndex = viewModel?.currentIndex else { return }
        //if userAnswer == questions[questionIndex].correct_answer {
        if userAnswer == viewModel?.questions[currentIndex].correct_answer {
            score += 1
        }
        //questionIndex += 1
        viewModel?.currentIndex += 1
        checkIndex()
    }
    
    private func nextQuestion(_ index: Int) {
        DispatchQueue.main.async {
            //self.questionLabel.text = self.questions[index].question
            self.questionLabel.text = self.viewModel?.questions[index].question
            //if self.questions[index].type == "boolean" {
            if self.viewModel?.questions[index].type == "boolean" {
                self.answer1.isHidden = true
                self.answer2.isHidden = true
                self.answer3.isHidden = true
                self.answer4.isHidden = true
                self.trueButton.isHidden = false
                self.falseButton.isHidden = false
            } else {
                self.answer1.isHidden = false
                self.answer2.isHidden = false
                self.answer3.isHidden = false
                self.answer4.isHidden = false
                self.trueButton.isHidden = true
                self.falseButton.isHidden = true
                
                //var questionsArray = self.questions[index].incorrect_answers
                //questionsArray.append(self.questions[index].correct_answer)
                var questionsArray = self.viewModel?.questions[index].incorrect_answers
                questionsArray?.append(self.viewModel?.questions[index].correct_answer ?? "")
                questionsArray?.shuffle()
                
                self.answer1.setTitle(questionsArray?[0], for: .normal)
                self.answer2.setTitle(questionsArray?[1], for: .normal)
                self.answer3.setTitle(questionsArray?[2], for: .normal)
                self.answer4.setTitle(questionsArray?[3], for: .normal)
            }
        }
    }
    
    private func checkIndex() {
        guard let currentIndex = viewModel?.currentIndex else { return }
        //if questionIndex == 10 {
        if currentIndex == 10 {
            let ac = UIAlertController(title: "Final score", message: "Your final score is \(score) points. Do you want to play again ?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
                self.tryAgain()
            }))
            ac.addAction(UIAlertAction(title: "No", style: .destructive, handler: { [self] action in
                self.navigationController?.popViewController(animated: true)
                self.answer1.isEnabled = false
                self.answer2.isEnabled = false
                self.answer3.isEnabled = false
                self.answer4.isEnabled = false
                self.trueButton.isEnabled = false
                self.falseButton.isEnabled = false
                
                navigationItem.rightBarButtonItem?.isEnabled = true
            }))
            present(ac, animated: true)
        } else {
            //atualizarTela(questionIndex)
            nextQuestion(currentIndex)
        }
    }
    
    private func getQuestions(_ id: Int) {
//        let questionService = QuestionService()
//        questionService.getQuestions(category: id) { questions in
//            self.questions = questions
//            self.atualizarTela(self.questionIndex)
//        }
        viewModel?.getQuestions(for: id, completion: { [weak self] in
            guard let id = self?.viewModel?.currentIndex else { return }
            self?.nextQuestion(id)
        })
    }
    
    @objc private func tryAgain() {
        //questionIndex = 0
        viewModel?.currentIndex = 0
        score = 0
        getQuestions(id)
        answer1.isEnabled = true
        answer2.isEnabled = true
        answer3.isEnabled = true
        answer4.isEnabled = true
        trueButton.isEnabled = true
        falseButton.isEnabled = true
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    

}
