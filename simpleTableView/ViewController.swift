//
//  ViewController.swift
//  simpleTableView
//
//  Created by Terry Chen on 2020/2/1.
//  Copyright © 2020 Terry Chen. All rights reserved.
//

import UIKit

var currentIndexPath:IndexPath!

class ViewController: UIViewController{

    @IBOutlet var tableView:UITableView!
    var cities:[[String:Any]]! //initialize city dicitonary
    var selectedItems = [IndexPath]() //checkmark items
    var notificationCenter = NotificationCenter.default
    var cityUpdatedStatus:Bool = false
    let targetURL:URL = {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let targetPath = "\(path.first!)/citylist.plist"
        let targetURL = URL(fileURLWithPath: targetPath)
        return targetURL
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sourceURL = Bundle.main.url(forResource: "citylist", withExtension: "plist")!
        
        //create a copy of citylist inside sandbox (just one time)
        if !FileManager.default.fileExists(atPath: targetURL.path){
            if(try? FileManager.default.copyItem(at: sourceURL, to: targetURL)) == nil{
                print("Error: sourcURL is nil")
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        //let plistURL = Bundle.main.url(forResource:"citylist", withExtension: "plist")
        cities = NSArray(contentsOf: targetURL) as? [[String:Any]]
        
        //resign active (leave app) -> update
        notificationCenter.addObserver(self, selector: #selector(updatePlist(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        //terminate app -> update
        notificationCenter.addObserver(self, selector: #selector(updatePlist(_:)), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "setDetail"){
            let city = sender as? [String:Any]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.city = city
            detailViewController.delegate = self
        }
    }
    
    @IBAction func userExit(_ sender:UIStoryboardSegue){
        print("user back")
    }
    
    @objc func updatePlist(_ sender:Any){
        if cityUpdatedStatus{
            
            (cities as NSArray).write(to: targetURL, atomically: true)
            
            cityUpdatedStatus = false
        }
    }

}

extension ViewController:UITableViewDataSource{
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
           return cities.count;
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
           let rowIndex = indexPath.row
           let city = cities[rowIndex]
           let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! CustomCell //prototype from storyboard
            
           cell.cityLabel.text = city["City"] as? String
           cell.countryLabel.text = city["Country"] as? String
           cell.continentLabel.text = city["Continent"] as? String
           cell.cityImage.image = UIImage(named: city["Image"] as! String)
           cell.cityImage.layer.cornerRadius = 35.0 //rounded icon
              
            //check mark
            if selectedItems.contains(indexPath){
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            
           return cell
        }
    
}

//Alert Popup
extension ViewController:UITableViewDelegate{
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let optionMenu = UIAlertController(title: "", message: "What do you want", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        let callAction = UIAlertAction(title: "Contact Me", style: .default, handler:{
            (action:UIAlertAction) -> Void in
            let alertMessage = UIAlertController(title: "Connection Failed", message: "Trying to connect..", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alertMessage,animated: true)
        })
        optionMenu.addAction(callAction)
        
        present(optionMenu, animated: true, completion: nil)
        
        //toggle checkmark for each cell
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            selectedItems = selectedItems.filter { (path:IndexPath) -> Bool in
               path != indexPath
            }
        }else{
            cell.accessoryType = .checkmark
            selectedItems.append(indexPath)
        }
    }
 */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let city = cities[indexPath.row]
        currentIndexPath = indexPath
        performSegue(withIdentifier: "setDetail", sender: city)
    }
    
    /*
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") {
            (_, _) in
            print("row action")
        }

        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (UITableViewRowAction, IndexPath) in
            self.selectedItems = self.selectedItems.filter { (path:IndexPath) -> Bool in
               path != indexPath
            }
            //delete cell and cell content
            self.cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        shareAction.backgroundColor = UIColor.blue
        return [shareAction,deleteAction]
    }
    */
}

extension ViewController:DetailViewControllerDelegate{
    
    func cityUpdate(updatedCity city: [String : Any]) {
        cities[currentIndexPath.row] = city
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.endUpdates()
        
        cityUpdatedStatus = true
    }
    
}
