//
//  HomeViewController.swift
//  FaceAnswer
//
//  Created by Şafak Can Baş on 16.08.2021.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var difficultyPicker: UIPickerView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    var difficultyPickerData: [String] = []
    var categoryPickerData: [String] = []
    var selectedDifficulty: String = ""
    var selectedCategory: String = ""
    @IBOutlet weak var nextpageButton: UIButton!
    
    @IBAction func startQuizButton(_ sender: UIButton) {
        fetchQuizData()
        print ( getDifficultyEnum(for: difficultyType(rawValue: selectedDifficulty) ?? .Mixed))
        print (getCategoryEnum(for: categoryType(rawValue: selectedCategory) ?? .Mixed))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        difficultyPickerData = [difficultyType.Easy.rawValue,difficultyType.Medium.rawValue,difficultyType.Hard.rawValue,difficultyType.Mixed.rawValue]
        categoryPickerData = [categoryType.Mixed.rawValue,categoryType.General_Knowledge.rawValue,categoryType.Video_Games.rawValue,categoryType.Sports.rawValue,categoryType.History.rawValue,categoryType.Computers.rawValue]
    }

    func configureUI(){
        nextpageButton.titleLabel?.font = UIFont(name: "HoeflerText-Black" , size: 15)
        nextpageButton.setTitle("NEXT", for: .normal)
        nextpageButton.titleLabel?.tintColor = .black
        nextpageButton.backgroundColor = UIColor(red: 2/255, green: 96/255, blue: 130/255, alpha: 1.0)
        nextpageButton.layer.borderColor = UIColor.white.cgColor
        nextpageButton.layer.cornerRadius = 5
    }
    
    func fetchQuizData() {
        let difficulty = getDifficultyEnum(for: difficultyType(rawValue: selectedDifficulty) ?? .Mixed)
        let category = getCategoryEnum(for: categoryType(rawValue: selectedCategory) ?? .Mixed)
        
        NetworkSession().fetchMovieList(difficulty: difficulty, category: category) { [weak self] results, error in
            if let results = results, !results.isEmpty {
                self?.pushToQuizViewController(fetched: results)
            }
        }
    }
    
    func pushToQuizViewController(fetched quiz: [QuizModel]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuizViewController") as QuizViewController
        viewController.quizArray = quiz
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getDifficultyEnum(for string: difficultyType)-> String {
        switch string {
        case .Easy: return "&difficulty=easy"
        case .Medium: return "&difficulty=medium"
        case .Hard: return "&difficulty=hard"
        case .Mixed: return ""
        }
    }
    func getCategoryEnum(for string: categoryType)-> String {
        switch string {
        case .Mixed : return ""
        case .General_Knowledge : return "&category=9"
        case .Video_Games : return "&category=15"
        case .Sports : return "&category=21"
        case .History : return "&category=23"
        case .Computers : return "&category=18"
        }
    }
}

extension HomeViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return difficultyPickerData.count
        } else {
            return categoryPickerData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            self.selectedDifficulty = difficultyPickerData[row]
            return "\(difficultyPickerData[row])"
        } else {
            self.selectedCategory = categoryPickerData[row]
            return "\(categoryPickerData[row])"
        }
    }

}
enum difficultyType: String {
    case Easy,Medium,Hard,Mixed
    }
enum categoryType: String {
    case Mixed,General_Knowledge,Video_Games,Sports,History,Computers
}
