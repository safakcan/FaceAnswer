//
//  QuizTableViewCell.swift
//  FaceAnswer
//
//  Created by Şafak Can Baş on 15.08.2021.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    static let identifier = "QuizTableViewCell"

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet var answerButtonCollection: [UIButton]!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        containerView.layer.cornerRadius = 5
        questionLabel.font = UIFont(name: "HoeflerText-Black" , size: 20)
        for button in answerButtonCollection {
            button.backgroundColor = .white
            button.titleLabel?.font = UIFont(name: "HoeflerText-Black" , size: 15)
            button.titleLabel?.tintColor = UIColor(red: 2/255, green: 96/255, blue: 130/255, alpha: 1.0)
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.cornerRadius = 5
        }
    }
    func configure(with model: QuizModel) {
        questionLabel.text = model.question
        let array = shuffleAnswers(with: model)
        for index in 0...answerButtonCollection.count - 1 {
            answerButtonCollection[index].setTitle(array[index], for: .normal)
        }

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "QuizTableViewCell", bundle: nil)
    }
    
    func shuffleAnswers(with model: QuizModel ) -> [String] {
        var array: [String] = []
        array.append(contentsOf: model.incorrectAnswers ?? [])
        array.append(model.correctAnswer ?? "")
        
        return array.shuffled()
    }
    
    func timeIsupBehaviour(correctAnswer: String) {
        for button in answerButtonCollection {
            if button.titleLabel?.text == correctAnswer {
                button.backgroundColor = .green
            }
            else {
                button.backgroundColor = .red
            }
        }
    }
}
