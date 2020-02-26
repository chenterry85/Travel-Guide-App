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
    @IBOutlet var containerView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //blur background image
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        backgroundImageView.addSubview(blurEffectView)
        
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        gestureRecognizer.direction = .down
        gestureRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gestureRecognizer)
        
        containerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        containerView.layer.cornerRadius = 10
        
    }
    
    //Make the White Navigation Bar Dissappear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //Part of Animation
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.containerView.transform = CGAffineTransform.identity //transform back to identity (original form)
        }
    }
    
    @objc func swipeRight(_ sender:UISwipeGestureRecognizer){
        //navigate back to last scene
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
