//
//  YouTubePlayerViewController.swift
//  Strater3
//
//  Created by Ryan Willson on 7/13/21.
//

import UIKit
import YouTubePlayer

class YouTubePlayerViewController: UIViewController {

    @IBOutlet var videoPlayer: YouTubePlayerView!

    var youtubeId : String? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = youtubeId{
            // Load video from YouTube ID
            videoPlayer.loadVideoID(id)
            videoPlayer.play()
        }else{
            // invalid youtube id
            print("Invalid YoutubeID")
        }

    }

    @IBAction func onClickDismiss(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
   
}
