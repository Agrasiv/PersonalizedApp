//
//  ViewController.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import UIKit

class ViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTappedGetStart(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "HealthConcernsViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HealthConcernsViewController") as! HealthConcernsViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
        
    }
    
}

