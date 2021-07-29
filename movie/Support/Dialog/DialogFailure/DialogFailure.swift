//
//  DialogFailure.swift
//  movie
//
//  Created by Samsud Dhuha on 29/07/21.
//

import Foundation
import UIKit
import MaterialComponents.MaterialBottomSheet

class DialogFailure: UIViewController {
    let TAG_DIALOG_FAILURE = "TAG-DIALOG-FAILURE"
    @IBOutlet weak var labelMessage: UILabel!
    var dataMessage: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.roundCorners([.topLeft, .topRight], radius: 8.0)
        
        if dataMessage != "" {
            labelMessage.text = dataMessage
        }
        
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func showDialog(parent: UIViewController, message: String!){
        let viewController = DialogFailure()
        viewController.dataMessage = message
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)
        bottomSheet.adjustHeightForSafeAreaInsets = true
        bottomSheet.preferredContentSize = CGSize(width: viewController.view.frame.size.width, height: viewController.view.frame.size.height)
        parent.present(bottomSheet, animated: true, completion: nil)
    }
}
