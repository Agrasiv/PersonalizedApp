//
//  LastPageViewController.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import UIKit
import DLRadioButton

class LastPageViewController: BaseViewController {
    
    @IBOutlet weak var btnSunYes: DLRadioButton!
    @IBOutlet weak var btnSunNo: DLRadioButton!
    @IBOutlet weak var btnSmokeYes: DLRadioButton!
    @IBOutlet weak var btnSmokeNo: DLRadioButton!
    @IBOutlet weak var btnZeroOne: DLRadioButton!
    @IBOutlet weak var btnTwoFive: DLRadioButton!
    @IBOutlet weak var btnFivePlus: DLRadioButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var hearthConcernsList: [HearthConcernsModelData] = []
    var dietsList: [DietsModelData] = []
    var alliergiesList: [AllergiesModelData] = []
    var sunLimit: Bool?
    var smoke: Bool?
    var alcoho: String?
    var totalTime = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProgressBar()
    }
    
    func getProgressBar() {
        progressBar.progress = Float(totalTime) / Float(totalTime)
    }
    
    
    @IBAction func didTapSunYes(_ sender: Any) {
        sunLimit = true
    }
    
    @IBAction func didTapSunNo(_ sender: Any) {
        sunLimit = false
    }
    
    @IBAction func didTappedSmokeYes(_ sender: Any) {
        smoke = true
    }
    
    @IBAction func didTappedSmokeNo(_ sender: Any) {
        smoke = false
        
    }
    
    @IBAction func didTappedZeroOne(_ sender: UIButton) {
        alcoho = sender.titleLabel?.text
    }
    
    @IBAction func didTappedTwoFive(_ sender: UIButton) {
        alcoho = sender.titleLabel?.text
    }
    
    @IBAction func didTappedFivePlus(_ sender: UIButton) {
        alcoho = sender.titleLabel?.text
    }
    
    @IBAction func didTappedGetMyVitamin(_ sender: Any) {
        if smoke != nil && alcoho != "" && sunLimit != nil {
            let latestModel = latestModel(health_concerns: hearthConcernsList,
                                          diets: dietsList,
                                          is_daily_exposure: sunLimit ?? false,
                                          is_smoke: smoke ?? false,
                                          alchol: alcoho ?? "",
                                          allergies: alliergiesList)
            
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(latestModel)
                let string: String? = String(data: data, encoding: .utf8)
                print(string)
            } catch {
                print("Uncode Error")
            }
        } else {
            showToast(message: "Need To Selected Above Questions")
        }
    }
    
}

struct latestModel: Codable {
    let health_concerns: [HearthConcernsModelData]
    let diets: [DietsModelData]?
    let is_daily_exposure: Bool
    let is_smoke: Bool
    let alchol: String
    let allergies: [AllergiesModelData]
}
