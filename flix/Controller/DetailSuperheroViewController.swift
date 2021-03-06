//
//  DetailSuperheroViewController.swift
//  flix
//
//  Created by Matthew on 9/17/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit

class DetailSuperheroViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            if let voteAverage = movie["vote_average"] as? Double {
                ratingLabel.text = String(voteAverage)
            } else {
                ratingLabel.text = "Null"
            }
            overviewLabel.text = movie["overview"] as? String
            overviewLabel.sizeToFit()
            
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString + backdropPathString)!
            backdropImageView.af_setImage(withURL: backdropURL)
            
            let posterURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterURL)
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerButton = sender as! UIButton
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movie = movie
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
