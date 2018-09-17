//
//  SuperheroViewController.swift
//  flix
//
//  Created by Matthew on 9/16/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit
import AlamofireImage

// SuperheroVC is also UICollectionViewDataSource so that collectionView.dataSource can be assigned to itself
// To have SuperheroVC conform to protocol of UICollectionViewDataSource, we have to implement specific methods
// cmd + click UICollectionViewDataSource to which methods are non-optional and have to be implemented
class SuperheroViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        fetchMovies()
    }
    
    // The 2 functions below is implemented to adhere to protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        // check if poster_path is nil before unwrapping
        if let posterPathString = movie["poster_path"] as? String {
            // if not nil
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURLString + posterPathString)!
            cell.posterImageView.af_setImage(withURL: posterURL)
        }
        
        return cell
    }
    
    func fetchMovies() {
        // Network Request > JSON data returned > Parse JSON data > Turn into
        // Swift Dictionary > Access Keys of Dictionary
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                // movies is a local variable with local scope
                self.movies = movies    //self.movies is the global variable
                self.collectionView.reloadData() //network requests load slower than the app set-up. need to reloadData once network request data comes in
                
                /*
                 HUD.hide(afterDelay: 1.0)
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                 self.refreshControl.endRefreshing()
                 })
                 */
            }
        }
        task.resume()
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
