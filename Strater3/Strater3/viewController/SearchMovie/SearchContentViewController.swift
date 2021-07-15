//
//  SearchContentViewController.swift
//  Strater3
//
//  Created by Ryan Willson on 7/15/21.
//

import UIKit

class SearchContentViewController: UIViewController {

    @IBOutlet weak var ivBack: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initGestureRecognizerBack()
        
        
    }


    
    private func initGestureRecognizerBack(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapButton))
        ivBack.isUserInteractionEnabled = true
        ivBack.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func onTapButton(){
    
        self.dismiss(animated: true, completion: nil)
        
    }
}
