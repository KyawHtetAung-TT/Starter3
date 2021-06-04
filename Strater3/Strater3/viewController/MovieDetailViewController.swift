//
//  MovieDetailViewController.swift
//  Strater3
//
//  Created by Ryan Willson on 6/3/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var ivBack: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initGestureRecognizerBack()
        
        // Do any additional setup after loading the view.
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
