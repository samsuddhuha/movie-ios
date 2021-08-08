//
//  MovieDetailViewController.swift
//  movie
//
//  Created by Samsud Dhuha on 29/07/21.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReview: UILabel!
    @IBOutlet weak var labelRelease: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var module: MovieModule?
    var data: Movie?
    var listVideo: [ResultVideo]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        module = MovieModule.init(viewStateDelegate: self, controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setView(){
        module?.getVideo(idMovie: (data?.id)!)
        
        labelTitle.text = data?.title
        labelReview.text = String((data?.voteAverage)!)
        labelOverview.text = data?.overview
        imageMovie.downloaded(from: BASE_URL_IMAGE+(data?.posterPath!)!)
    }
}


extension MovieDetailViewController: ViewStateDelegate{
    func onSuccess(data: Any?, tag: String, message: String) {
        listVideo = (data as? [ResultVideo])!
        
        let youtubeURL = "https://www.youtube.com/embed/\(listVideo![0].key!)"
        webView.loadHTMLString("<iframe width=\"100%%\" height=\"97%%\" src=\"\(youtubeURL)?&rel=0\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)

    }
    
    func onFailure(data: Any?, tag: String, message: String) {
        DialogFailure().showDialog(parent: self, message: message)
    }
    
    func onLoading(isLoading: Bool, tag: String, message: String) {
        showLoadingView(state: isLoading)
    }
    
    
}
