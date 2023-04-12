//
//  SignUpViewController.swift
//  Assignment-1
//
//  Created by Nikhil Saini on 11/04/23.
//

import UIKit
import AVKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpVideo()
    }
    
    func setUpElements() {
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
        
    }

    func setUpVideo() {
        
        let bundlePath = Bundle.main.path(forResource: "signOutbg", ofType: "mp4")
        
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
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            
            return "Please Enter First Name."
        }
        
        if lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please Enter Last Name."
            
        }
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please Enter Email."
            
        }
        
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please Enter Password."
            
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPassword(cleanedPassword) == false {
            
            return "Please Enter Valid Password."
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = isValidate()
        
        if error != nil {
            
            self.present(Utilities.createAlertController(title: "Error", message: error!), animated: true, completion: nil)
        }
        else {
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, err) in
                
                if err != nil {
                    
                    self.present(Utilities.createAlertController(title: "Error", message: err!.localizedDescription), animated: true, completion: nil)
                    
                    return
                    
                }
                else {
                    
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            
                            self.present(Utilities.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
                            
                            return
                        }
                        
                    }
                    self.performSegue(withIdentifier: "userSignUpSegue", sender: nil)
                }
                
                
                
            }
        }
        
       
        
    }
    

}
