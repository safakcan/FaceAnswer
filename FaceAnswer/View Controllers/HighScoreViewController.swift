//
//  HighScoreViewController.swift
//  FaceAnswer
//
//  Created by Şafak Can Baş on 22.08.2021.
//

import UIKit
import FirebaseFirestore

class HighScoreViewController: UIViewController {
    let session = NetworkSession()
    @IBOutlet weak var tableView: UITableView!
    var highScoreList: [[String:Any]] = []
    var userList: [UserModel] = []
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "High Score"
        scoreLabel.font = UIFont(name: "HoeflerText-Black" , size: 30)
        tableView.register(HighScoreTableViewCell.nib(), forCellReuseIdentifier: HighScoreTableViewCell.identifier)
        fetchHighScoreList()
        // Do any additional setup after loading the view.
    }
    
    func fetchHighScoreList() {
        session.readDataFromDB { result, error in
            guard let result = result else {return}
            for list in result {
                let user = UserModel(username: list["name"] as! String, score: list["score"] as! String )
                self.userList.append(user)
            }
            self.configureTableData()
        }
    }
    
    func configureTableData() {
        userList.sort(by: {($0.score>$1.score)})
        tableView.reloadData()
    }
}


extension HighScoreViewController: UITabBarDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HighScoreTableViewCell.identifier) as! HighScoreTableViewCell
        
        cell.configure(with: userList[indexPath.row], index: indexPath.row+1)
        
        return cell
    }
    
    
}
