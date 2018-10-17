//
//  ViewController.swift
//  ScriglovIOS
//
//  Created by Benjamin Dubus on 10/10/2018.
//  Copyright © 2018 Benjamin Dubus. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var text:String = ""
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    //The login script url make sure to write the ip instead of localhost
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "https://api.scriglov.fr/login"
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    //the connected views
    //don't copy instead connect the views using assistant editor
    //@IBOutlet weak var labelMessage: UILabel!
    //@IBOutlet weak var textFieldUserName: UITextField!
    //@IBOutlet weak var textFieldPassword: UITextField!
    @IBAction func SignUP(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "SecondViewController") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func buttonLogin(_ sender: UIButton) {

        //getting the username and password
        let parameters: Parameters=[
            "mail":mailField.text!,
            "pass":passwordField.text!
        ]
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        //let userEmail = self.mailField.text!
                        //getting the user from response
                        let user = jsonData.value(forKey: "response") as! String
                        
                        print(user)
                            let mail = self.mailField.text!
                            print(mail)
                            self.defaultValues.set(mail, forKey: "mail")
                            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as UIViewController
                            self.present(vc, animated: true, completion: nil)
                        //switching the screen
                        //let profileView Controller = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                        //self.navigationController?.pushViewController(profileViewController, animated: true)
                        //self.dismiss(animated: true, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        self.labelMessage.text = "Mot de passe ou adresse mail invalide"
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hiding the navigation button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
        if defaultValues.string(forKey: "response") != nil{
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
            self.navigationController?.pushViewController(profileViewController, animated: true)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
