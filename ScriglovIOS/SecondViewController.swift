//
//  SecondViewController.swift
//  ScriglovIOS
//
//  Created by Benjamin Dubus on 15/10/2018.
//  Copyright © 2018 Benjamin Dubus. All rights reserved.
//

import Alamofire
import UIKit

let URL_USER_REGISTER = "https://api.scriglov.fr/sign_up"


class SecondViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var textFieldLastname: UITextField!
    @IBOutlet weak var textFieldFirstname: UITextField!
    @IBOutlet weak var textFieldMail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmedPassword: UITextField!
    
    @IBAction func signup(_ sender: UIButton) {
        //creating parameters for the post request
        let parameters: Parameters=[
            "name":textFieldFirstname.text!,
            "pass":textFieldPassword.text!,
            "surname":textFieldLastname.text!,
            "mail":textFieldMail.text!,
            "doc":"None"
        ]
        
        var a = false
        var b = false
        var label = ""
        if textFieldConfirmedPassword.text == textFieldPassword.text {
            a = true
        }
        else
        {
            label = "Les deux champs de mot de passe ne corespondent pas"
        }
        if(textFieldPassword.text == "" || textFieldPassword.text == "")
        {
            label = "Le mot de passe n'est pas sécurisé"
        }
        else
        {
            b = true
        }
        if a == true && b == true {
            //Sending http post request
            Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    //getting the json value from the server
                    if let result = response.result.value {
                        
                        //converting it as NSDictionary
                        let jsonData = result as! NSDictionary
                    }
            }
        }
}
}
