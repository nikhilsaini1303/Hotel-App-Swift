//
//  ViewController.swift
//  Assignment-1
//
//  Created by Nikhil Saini on 11/04/23.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let defaults = UserDefaults.standard.value(forKey: "email")
        
        if defaults != nil {
            let viewController = self.storyboard?.instantiateViewController(identifier: "navTabID") as! UINavigationController
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true, completion: nil)
        }
        
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpVideo()
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }
    
    func setUpVideo() {
        
        let bundlePath = Bundle.main.path(forResource: "login", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        let item = AVPlayerItem(url: url)
        
        videoPlayer = AVPlayer(playerItem: item)
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        videoPlayer?.playImmediately(atRate: 0.3)
        
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "signInSegue", sender: nil)
        
    }

}

