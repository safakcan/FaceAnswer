//
//  ViewController.swift
//  FaceAnswer
//
//  Created by Şafak Can Baş on 15.08.2021.
//

import UIKit
import FirebaseFirestore

class OnboardViewController: UIViewController {
    let database = Firestore.firestore()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextpageButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        nameTextField.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        configureOutlets()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func pushToHomeAction(_ sender: UIButton) {
        if nameTextField.text?.count ?? 0 > 2 {
        TempUserModel.shared.tempUsername = nameTextField.text
        pushToHomeViewController()
        }
    }
    
    func configureOutlets() {
        
        self.view.backgroundColor = .opaqueSeparator
        
        titleLabel.text = "Face Answer"
        titleLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
        titleLabel.textColor = .black
        
        nextpageButton.titleLabel?.font = UIFont(name: "HoeflerText-Black" , size: 15)
        nextpageButton.setTitle("NEXT", for: .normal)
        nextpageButton.titleLabel?.tintColor = .black
        nextpageButton.backgroundColor = UIColor(red: 2/255, green: 96/255, blue: 130/255, alpha: 1.0)
        nextpageButton.layer.borderColor = UIColor.white.cgColor
        nextpageButton.layer.cornerRadius = 5
        
        nameTextField.backgroundColor = .black
        nameTextField.borderStyle = .roundedRect
        nameTextField.attributedPlaceholder =
        NSAttributedString(string: "Enter a name...(more than 2 caracters)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        nameTextField.textColor = .white
    }
    
    func pushToHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "HomeViewController") as HomeViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension OnboardViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.canBeConverted(to: String.Encoding.ascii){
                return false
            }
         guard let text = textField.text else { return true }
         let newLength = text.count + string.count - range.length
         return newLength <= 15
    }
}

