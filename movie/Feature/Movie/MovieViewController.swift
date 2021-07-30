//
//  MovieViewController.swift
//  movie
//
//  Created by Samsud Dhuha on 28/07/21.
//

import Foundation
import UIKit
import iOSNFramework

class MovieViewController: UIViewController, PopUpDelegate {
    
    @IBOutlet weak var displaySelectGenre: UIView!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var tableMovie: UITableView!
    
    var tableInfinity: TableInfinityScroll!
    
    var module: MovieModule?
    var listGenre = [Genre]()
    var listMovie = [Movie]()
    var idGenre: Int?
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableMovie.delegate = self
        tableMovie.dataSource = self
        
        module = MovieModule.init(viewStateDelegate: self, controller: self)
        
        tableInfinity = TableInfinityScroll(table: tableMovie, action: {
            if self.idGenre == nil{
                self.module?.getListMovie(idGenre: "", language: "en-US", page: self.page)
            }else{
                self.module?.getListMovie(idGenre: String(self.idGenre!), language: "en-US", page: self.page)
            }
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setView()
    }
    
    @IBAction func btnSelectGenre(_ sender: Any) {
        DialogGenre().showDialog(parent: self, listData: listGenre)
    }
    
    private func setView(){
        module?.getListGenre(language: "en-US")
        page = 1
        listMovie.removeAll()
    }
    
    func handleAction(tag: String, data: Any) {
        switch tag {
        case DialogGenre().TAG_GENRE:
            labelGenre.text = data as? String
            for i in (0..<listGenre.count) {
                if listGenre[i].name == data as? String {
                    idGenre = listGenre[i].id
                }
            }
            page = 1
            listMovie.removeAll()
            module?.getListMovie(idGenre: String(idGenre!), language: "en-US", page: page)
            
        default:
            labelGenre.text = "Select genre"
        }
    }
}

extension MovieViewController: ViewStateDelegate{
    func onSuccess(data: Any?, tag: String, message: String) {
        switch tag {
        case module?.TAG_GENRE:
            listGenre.removeAll()
            listGenre = data as! [Genre]
            if idGenre != nil {
                module?.getListMovie(idGenre: String(idGenre!) , language: "en-US", page: page)
            }else{
                module?.getListMovie(idGenre: "", language: "en-US", page: page)
            }
        default:
            page = page + 1
            let temp = data as! [Movie]
            let _ = temp.map{listMovie.append($0)}
            tableMovie.reloadData()
        }
    }
    
    func onFailure(data: Any?, tag: String, message: String) {
        DialogFailure().showDialog(parent: self, message: message)
    }
    
    func onUpdate(data: Any?, tag: String, message: String) {
        
    }
    
    func onLoading(isLoading: Bool, tag: String, message: String) {
        if page == 1 {
            showLoadingView(state: isLoading)
        }
        if isLoading {
        }else{
            tableInfinity.finishInfiniteScroll()
        }
    }
    
    
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableMovie.dequeueReusableCell(withIdentifier: "movieviewcell") as! MovieViewCell
        let data = listMovie[indexPath.row]
        cell.imageMovie.image = nil
        cell.labelTitle.text = data.title
        
        if data.vote_average != nil {
            cell.labelReview.text = String(data.vote_average!)
        }
        if data.poster_path != nil {
            cell.imageMovie.downloaded(from: BASE_URL_IMAGE+data.poster_path!)
        }
        if data.release_date != nil {
            cell.labelRelease.text = "Release : \(convertDateFormatter(date: data.release_date!))"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let temp = listMovie[indexPath.row]
        
        listMovie.removeAll()
        toDetailMovie(data: temp)
    }
    
    private func toDetailMovie(data: Movie) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Movie", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "moviedetailviewcontroller") as! MovieDetailViewController
        viewController.data = data
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableInfinity.scrollViewDidScroll(scrollView)
    }
    
}

