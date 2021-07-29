//
//  MovieViewCell.swift
//  movie
//
//  Created by Samsud Dhuha on 29/07/21.
//

import UIKit

class MovieViewCell: UITableViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var displayImage: UIView!
    @IBOutlet weak var labelReview: UILabel!
    @IBOutlet weak var labelRelease: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
