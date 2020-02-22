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
    weak var delegate:DetailViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

//UITableViewDelegate
extension DetailViewControllerDelegate{
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
//
//    }
    
}
