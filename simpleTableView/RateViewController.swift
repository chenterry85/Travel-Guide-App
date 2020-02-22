//
//  RateViewController.swift
//  simpleTableView
//
//  Created by Terry Chen on 2020/2/18.
//  Copyright © 2020 Terry Chen. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {

    @IBOutlet var backgroundImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        backgroundImageView.addSubview(blurEffectView)
        
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        gestureRecognizer.direction = .down
        gestureRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func swipeRight(_ sender:UISwipeGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
