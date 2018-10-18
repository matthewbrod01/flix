//
//  MovieCell.swift
//  flix
//
//  Created by Matthew on 9/8/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        willSet(movie) {
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.overview
            self.posterImageView.af_setImage(withURL: movie.posterUrl!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
