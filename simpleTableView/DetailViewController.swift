//
//  DetailViewController.swift
//  simpleTableView
//
//  Created by Terry Chen on 2020/2/8.
//  Copyright © 2020 Terry Chen. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate:AnyObject{
    func cityUpdate(updatedCity city:[String:Any]);
}

class DetailViewController: UITableViewController {

    var city:[String:Any]!
    @IBOutlet var countryField:UITextField!
    @IBOutlet var continenField:UITextField!
    @IBOutlet var descriptionLabel:UITextView!
    @IBOutlet var rateButton:UIBarButtonItem!
    weak var delegate:DetailViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBarSettings()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 38.0
        
        (tableView.tableHeaderView as! UIImageView).image = UIImage(named: city["Image"]! as! String)
        title = city["City"] as? String
        countryField.text = city["Country"] as? String
        continenField.text = city["Continent"] as? String
        descriptionLabel.text = city["Local"] as? String
    }
    
    @IBAction func userBack(_ sender:UIBarButtonItem){
    
        city["Country"] = countryField.text
        city["Continent"] = continenField.text
        
        //pass back city
        delegate?.cityUpdate(updatedCity: city)
        
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func goBackToDetailView(_ sender:UIStoryboardSegue){
        print("go back detail view")
    }
    
    func initNavigationBarSettings(){
        let backButtonProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        backButtonProfile.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButtonProfile.backgroundColor = UIColor(red: (27/255), green: (32/255), blue: (45/255), alpha: 0.75)
        backButtonProfile.layer.cornerRadius = 20
        backButtonProfile.layer.masksToBounds = true
       
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButtonProfile)
        
        
        let rateButtonProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 65, height: 20))
        backButtonProfile.backgroundColor = UIColor(red: (27/255), green: (32/255), blue: (45/255), alpha: 0.75)
        backButtonProfile.layer.cornerRadius = 10
        backButtonProfile.layer.masksToBounds = true

        rateButton = UIBarButtonItem(customView: rateButtonProfile)	
        
    }
    
}

//UITableViewDelegate
//extension DetailViewControllerDelegate{
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 20))
//        headerView.backgroundColor = .blue
//        return headerView
//    }
//    
//}
