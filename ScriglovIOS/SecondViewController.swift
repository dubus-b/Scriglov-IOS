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
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmedPassword: UITextField!
    
    @IBAction func signup(_ sender: UIButton) {
        
        print("sign")
        //creating parameters for the post request
        let parameters: Parameters=[
            "name":firstName.text!,
            "pass":password.text!,
            "surname":lastName.text!,
            "mail":mail.text!,
            "doc":"None"
        ]
        
        var a = false
        var b = false
        var label = ""
        if confirmedPassword.text == password.text {
            a = true
        }
        else
        {
            label = "Les deux champs de mot de passe ne corespondent pas"
        }
        if(confirmedPassword.text == "" || password.text == "")
        {
            label = "Le mot de passe n'est pas assez long"
        }
        else
        {
            b = true
            self.label.text = label
        }
        self.label.text = label
        if a == true && b == true {
            //Sending http post request
            Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    //getting the json value from the server
                    if let result = response.result.value {
                        
                        //converting it as NSDictionary
                        let jsonData = result as! NSDictionary
                        label = jsonData.value(forKey: "response") as! String
                        self.label.text = label
                    }
            }
        }
}
}
