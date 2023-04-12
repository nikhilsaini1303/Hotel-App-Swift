//
//  LoginViewController.swift
//  Assignment-1
//
//  Created by Nikhil Saini on 11/04/23.
//

import UIKit
import AVKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpVideo()
    }
    
    
    func setUpElements() {
        
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
        
    }
    
    func setUpVideo() {
        
        let bundlePath = Bundle.main.path(forResource: "signInbg", ofType: "mp4")
        
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
    
    func isValidate() -> String? {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please Enter Email."
        }
        
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please Enter Password."
            
        }
        
        return nil
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let error = isValidate()
        
        if error != nil {
            
            self.present(Utilities.createAlertController(title: "Error", message: error!), animated: true, completion: nil)
            
        }
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                
                if error != nil {
                    
                    self.present(Utilities.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
                    
                    return
                    
                }
                
                self.performSegue(withIdentifier: "userLoginSegue", sender: nil)
            }
        }
        
       
        
    }
    
}
