//
//  ProfileViewController.swift
//  ScriglovIOS
//
//  Created by Benjamin Dubus on 15/10/2018.
//  Copyright © 2018 Benjamin Dubus. All rights reserved.
//

import UIKit
import Alamofire
import Foundation


public func get_overview() -> Array<Any> {
    let defaultValues = UserDefaults.standard
    var name:String
    name = defaultValues.string(forKey: "mail") as! String
    let parameters: Parameters=[
        "mail":"benjamin.dubus@epitech.eu"
    ]
    Alamofire.request("https://api.scriglov.fr/account_overview", method: .post, parameters: parameters).responseJSON
        {
            response in
            //printing response
            print(response)
            
            //getting the json value from the server
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                    //getting the user from response
                let user = jsonData.value(forKey: "response") as! NSArray
                    //getting user values
                
                }
    }
    var account = ["Nom", "Prénom", name]
    return account
}
class ProfileViewController: UIViewController, UITableViewDataSource {
    
    let URL_USER_OVER = "https://api.scriglov.fr/account_overview"
    let sections = ["Menu", "Informations du compte"]
    let menu = ["Statistiques", "Exercice", "A propos", "Guide d'utilisation", "Gestion du compte"]
    var account_overview = ["", "test"]
    var test = get_overview()
    let parameters: Parameters=[
        "mail":"benjamin.dubus@epitech.eu"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            // Fruit Section
            return menu.count
        case 1:
            // Vegetable Section
            return account_overview.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an object of the dynamic cell "PlainCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath)
        // Depending on the section, fill the textLabel with the relevant text
        switch indexPath.section {
        case 0:
            // Fruit Section
            cell.textLabel?.text = menu[indexPath.row]
            break
        case 1:
            // Vegetable Section
            account_overview = test as! [String]
            cell.textLabel?.text = account_overview[indexPath.row]
            break
        default:
            break
        }
        // Return the configured cell
        return cell
    }
    
}
