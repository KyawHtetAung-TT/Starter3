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
    
//    func navigateToSearchViewController(){
//        let vc = SearchContentViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
//
//    }
    
//    func navigateToViewMoreActorViewController(data : ActorListResponse){
//        let vc = ViewMoreActorViewController()
//        vc.initData = data
//        present(vc, animated: true, completion: nil)
//
//    }
//
//    func navigateToViewMoreShowCaseViewController(data : MovieListResponse){
//        let vc = ViewMoreShowcaseViewController()
//        vc.initData = data
//        present(vc, animated: true, completion: nil)
//
//    }
    
    // movie detail // showcase
    func nevigateToMovieDetailViewController(movieId: Int){
//        let storyBoard = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
        
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController  else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.movieID = movieId
//        vc.contentType = .movie
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
    
    func nevigateToMoreShowcaseViewController(){
        let vc = ViewMoreShowcaseViewController()
        
//        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: ViewMoreShowcaseViewController.identifier) as? ViewMoreShowcaseViewController  else { return }
        vc.modalPresentationStyle = .automatic
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    func nevigateToViewMoreActorViewController(){
        let vc = ViewMoreActorViewController()
        vc.modalPresentationStyle = .automatic
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    
    // Actor detail
    func nevigateToActorDetailViewController(actorId : Int) {
//        let storyBoard = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)

        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: ActorDetailViewController.identifier) as? ActorDetailViewController  else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.actorID = actorId
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
}
