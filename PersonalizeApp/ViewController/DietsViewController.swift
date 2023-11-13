//
//  DietsViewController.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import UIKit
import Combine

class DietsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var bindings = Set<AnyCancellable>()
    var viewModel = DietViewModel()
    var dietsList: [DietsModelData]?
    var selectedData: [DietsModelData] = []
    var hearthConcernsList: [HearthConcernsModelData] = []
    var totalTime = 4 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUptableView()
        getDietsList()
        getProgressBar()
    }
    
    func setUptableView() {
        tableView.registerForCells(cells: DietsTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getProgressBar() {
        progressBar.progress = Float(totalTime - 2) / Float(totalTime)
    }
    
    func getDietsList() {
        viewModel.getDietsData()
        viewModel.getDietsList.sink { [weak self] dietsList in
            self?.dietsList = dietsList
            self?.tableView.reloadData()
        }
        .store(in: &bindings)
    }
    
    @IBAction func didTappedBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    
    @IBAction func didTappedNext(_ sender: Any) {
        if selectedData.count > 0 {
            let storyboard: UIStoryboard = UIStoryboard(name: "AllergiesViewController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AllergiesViewController") as! AllergiesViewController
            vc.modalPresentationStyle = .fullScreen
            vc.hearthConcernsList = hearthConcernsList
            vc.dietsList = selectedData
            self.present(vc, animated: false)
        } else {
            self.showToast(message: "Please select 1 Or More")
        }
    }
    
}

extension DietsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dietsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReuseCell(type: DietsTableViewCell.self, indexPath: indexPath)
        cell.name.text = dietsList?[indexPath.row].name
        cell.index = indexPath.row
        cell.diets = dietsList?[indexPath.row]
        cell.delegte = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension DietsViewController: DietsTableViewCellProtocol {
    
    func didTappedInfo(sender: UIButton, index: Int) {
//        let popoverContent = PopoverViewController()
//        popoverContent.label.text = dietsList?[index].tool_tip
//        presentPopover(self, popoverContent, sender: sender, size: CGSize(width: 160, height: 45), arrowDirection: .left)
    }
    
    
    func toAdd(index: Int, diets: DietsModelData) {
        selectedData.append(diets)
    }
    
    func toRemove(index: Int, diets: DietsModelData) {
        let id = dietsList?[index].id
        let foundIndex = selectedData.firstIndex { data in
            if data.id == id {
                return true
            }
            return false
        } ?? 0
        selectedData.remove(at: foundIndex)
    }
}
