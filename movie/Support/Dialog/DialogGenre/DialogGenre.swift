//
//  DialogGenre.swift
//  movie
//
//  Created by Samsud Dhuha on 29/07/21.
//

import UIKit

class DialogGenre: UIViewController {
    
    let TAG_GENRE = "TAG-GENRE"

    @IBOutlet weak var tableGenre: UITableView!
    @IBOutlet weak var dialogView: UIView!
    
    var listGenre = [Genre]()
    var delegate: PopUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableGenre.delegate = self
        tableGenre.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView()
    }
    
    private func setView(){
        tableGenre.reloadData()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        dialogView.layer.cornerRadius = 8.0
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showDialog(parent: UIViewController, listData: [Genre]) {
        if let popupViewController = UIStoryboard(name: "DialogGenre", bundle: nil).instantiateViewController(withIdentifier: "dialoggenreviewcontroller") as? DialogGenre {
            popupViewController.listGenre.removeAll()
            popupViewController.listGenre = listData
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            popupViewController.delegate = parent as? PopUpDelegate
            parent.present(popupViewController, animated: true)
        }
    }
}


extension DialogGenre: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGenre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableGenre.dequeueReusableCell(withIdentifier: "genreviewcell") as! GenreViewCell
        let data = listGenre[indexPath.row]
        
        cell.labelGenre.text = data.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let temp = listGenre[indexPath.row]
        self.delegate?.handleAction(tag: TAG_GENRE, data: temp.name!)
        self.dismiss(animated: true, completion: nil)
    }
    
}
