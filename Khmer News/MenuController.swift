//
//  MenuController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage
import FBSDKLoginKit


class MenuController: UITableViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var btnFacebook: FBSDKLoginButton!
    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        myImage.layer.cornerRadius = myImage.frame.size.height / 2
        myImage.layer.masksToBounds = true
        let image = UIImage(named: "Background")
        let imageView = UIImageView(image: image)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        imageView.contentMode = .scaleAspectFit
        btnFacebook.delegate = self
        btnFacebook.readPermissions = ["public_profile", "email", "user_friends"]

        
        
        self.tableView.backgroundView = imageView
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (auser, error) in
            // ...
            if (error == nil){
                if (auser != nil) {
                    print(auser!.displayName!)
                    self.myLabel.text = auser!.displayName!
                    
                }
                
               
                self.myImage.sd_setImage(with: auser?.photoURL)
                
                
                
            }else{
                print(error!)
            }
        }
        
        // ...
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        
        return true
    }

    
    
    
    
    
    
    
    
}
