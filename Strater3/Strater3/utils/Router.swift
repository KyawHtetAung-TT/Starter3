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
    
    // movie detail // showcase
    func nevigateToMovieDetailViewController(movieId: Int){
//        let storyBoard = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
        
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController  else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.movieID = movieId
        
        present(vc, animated: true)
    }
    
  
    
    
    // Actor detail
    func nevigateToActorDetailViewController(actorId : Int) {
//        let storyBoard = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)

        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: ActorDetailViewController.identifier) as? ActorDetailViewController  else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.actorID = actorId
        present(vc, animated: true)
    }
}
