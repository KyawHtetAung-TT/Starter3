//
//  Router.swift
//  Strater3
//
//  Created by Ryan Willson on 6/4/21.
//

import Foundation
import UIKit

enum StoryBoardName : String {
    case Main = "Main"
//    case Authentication = "Authentication"
    case LunchScreen = "LunchScreen"
}


extension UIStoryboard{
    
  static func mainStoryBoard()-> UIStoryboard{
        UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
    }
}

extension UIViewController{
    
    func nevigateToMovieDetailViewController(){
//        let storyBoard = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
        
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController  else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}
