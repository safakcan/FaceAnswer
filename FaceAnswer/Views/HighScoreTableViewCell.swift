//
//  HighScoreTableViewCell.swift
//  FaceAnswer
//
//  Created by Şafak Can Baş on 22.08.2021.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    static let identifier = "HighScoreTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "HighScoreTableViewCell", bundle: nil)
    }
    
    func configureUI() {
     //
    }
    func configure(with model: UserModel,index: Int) {
        nameLabel.text = String(index) + ". " + model.username
        scoreLabel.text = model.score
    }
}
