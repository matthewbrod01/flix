//
//  TrailerViewController.swift
//  flix
//
//  Created by Matthew on 9/17/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
    
    var movie: [String: Any]?
    var URLString: String = ""
    var youtubeLinks: [[String: Any]] = []
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            if let movieID = movie["id"] as? Int {
                let movieIDString = String(movieID)
                let apiString = "https://api.themoviedb.org/3/movie/\(movieIDString)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
                self.URLString = apiString
            }
        }
        fetchYoutubeLink()
    }
    
    func fetchYoutubeLink() {
        let url = URL(string: self.URLString)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let youtubeLinks = dataDictionary["results"] as! [[String: Any]]
                let trailerDictionary = youtubeLinks[0]
                let trailerKey = trailerDictionary["key"] as! String
                let trailerString = "https://www.youtube.com/watch?v=\(trailerKey)"
                let myURL = URL(string: trailerString)
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)
            }
        }
        task.resume()
    }
    
    @IBAction func tappedCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
