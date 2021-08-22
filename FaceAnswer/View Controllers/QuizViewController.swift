//
//  QuizViewController.swift
//  FaceAnswer
//
//  Created by Şafak Can Baş on 15.08.2021.
//

import UIKit
import FirebaseFirestore

class QuizViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let session = NetworkSession()
    var quizArray: [QuizModel] = []
    var quizQuestion: QuizModel?
    var counter = 24
    var timer : Timer?
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        quizQuestion = quizArray.first
        tableView.register(QuizTableViewCell.nib(), forCellReuseIdentifier: QuizTableViewCell.identifier)
        tableView.backgroundColor = .black
        restartTimer()
    }
    
    @objc func didTapMyButton(sender:UIButton!) {
        timer?.invalidate()
        evaluateAnswer(with: sender)
    }
    
    func evaluateAnswer(with sender: UIButton) {
        if sender.titleLabel?.text == quizQuestion?.correctAnswer {
            sender.backgroundColor = .green
            Sounds.shared.playSound(with: Sounds.shared.correctAnswerSound)
            score += 1
        }
        else {
            sender.backgroundColor = .red
            Sounds.shared.playSound(with: Sounds.shared.wrongAnswerSound)
        }
        self.nextQuestion()
    }
    
    func nextQuestion() {
        tableView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.restartTimer()
            if let found = self.quizArray.firstIndex(where: {$0.question == self.quizQuestion?.question}), found < self.quizArray.count-1 {
                self.quizQuestion = self.quizArray[found + 1]
                self.tableView.reloadData()
                self.tableView.isUserInteractionEnabled = true
            }
            else {
                self.timer?.invalidate()
                self.finishQuiz()
                self.pushToHighScoreViewController()
            }
        }
    }
    
    func finishQuiz() {
        guard let username = TempUserModel.shared.tempUsername else { return }
        self.session.writeDataToDB(username: username, score: self.score)
    }
    
    @objc func updateCounter() {
        if counter > -1 {
            countdownLabel.text = String(counter)
            counter -= 1
        }
        if counter == -1 {
            timer?.invalidate()
            guard let cell = tableView.visibleCells.first as? QuizTableViewCell else {return}
            cell.timeIsupBehaviour(correctAnswer: (quizQuestion?.correctAnswer)!)
            nextQuestion()
        }
    }
    
    func restartTimer() {
        self.counter = 24
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func pushToHighScoreViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "HighScoreViewController") as HighScoreViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizTableViewCell.identifier, for: indexPath) as! QuizTableViewCell
        cell.selectionStyle = .none
        cell.configureUI()
        cell.configure(with: quizQuestion!)
        
        for index in 0...cell.answerButtonCollection.count - 1 {
            cell.answerButtonCollection[index].addTarget(self, action: #selector(didTapMyButton), for: .touchUpInside)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}

