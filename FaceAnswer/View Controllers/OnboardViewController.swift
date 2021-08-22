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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    @IBAction func pushToHomeAction(_ sender: UIButton) {
        TempUserModel.shared.tempUsername = "safak23"
        pushToHomeViewController()
    }
    
    func pushToHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "HomeViewController") as HomeViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
//    func writeData() {
//        let collection = database.collection("HighScore")
//        collection.addDocument(data: ["name": "qwe","score": "789"])
//        collection.addDocument(data: ["name": "asd","score": "789"])
//        collection.addDocument(data: ["name": "zxc","score": "789"])
//        collection.addDocument(data: ["name": "dfg","score": "789"])
       // collection.addDocument(data: <#T##[String : Any]#>)
//        docRef.collection("list").addDocument(data: ["asd":["name": "qwe","score": "789"]])
//        docRef.collection("list").addDocument(data: ["asd":["name": "qwe","score": "123"]])
//        docRef.collection("list").addDocument(data: ["asd":["name": "qwe","score": "456"]])
    }

//    func getData() {
//        let collection = database.collection("HighScore")
//        collection.getDocuments(completion: { snap,error in
//            guard let data = snap?.documents else {return}
//            for d in data {
//                print(d.data())
//            }
//        })
//    }


