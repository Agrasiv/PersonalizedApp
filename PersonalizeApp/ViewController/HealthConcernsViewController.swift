//
//  HealthConcernsViewController.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import UIKit
import Combine

class HealthConcernsViewController: BaseViewController {
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var bindings = Set<AnyCancellable>()
    let viewModel = HealthConcernsViewModel()
    var healthConcerns: [HearthConcernsModelData]?
    var selectedData: [HearthConcernsModelData] = []
    var totalTime = 4 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        getHealthConsernsList()
        getProgressBar()
    }
    
    func setupCollectionView() {
        collectionView.registerForCells(cells: HealthConcernsCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = TagsLayout()
        collectionView.collectionViewLayout = layout
    }
    
    func setupTableView() {
        tableView.registerForCells(cells: HealthConcernsTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func getHealthConsernsList() {
        viewModel.getHealthConcernsData()
        
        viewModel.getHealthConcernsList.sink { [weak self] healthConcernsList in
            self?.healthConcerns = healthConcernsList
            self?.collectionView.reloadData()
        }
        .store(in: &bindings)
    }
    
    func getProgressBar() {
        progressBar.progress = Float(totalTime - 3) / Float(totalTime)
    }
    
    @IBAction func didTappedBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func didTappedNext(_ sender: Any) {
        if selectedData.count >= 5 {
            let storyboard: UIStoryboard = UIStoryboard(name: "DietsViewController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DietsViewController") as! DietsViewController
            vc.modalPresentationStyle = .fullScreen
            vc.hearthConcernsList = selectedData
            self.present(vc, animated: false)
        } else {
            self.showToast(message: "Please select 5 or more")
        }
    }
}

extension HealthConcernsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthConcerns?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReuseCell(type: HealthConcernsCollectionViewCell.self, indexPath: indexPath)
        cell.labelName.text = healthConcerns?[indexPath.row].name
        cell.index = indexPath.row
        cell.hearthConcerns = healthConcerns?[indexPath.row]
        if let isSelected =  healthConcerns?[indexPath.row].isSelected {
            cell.isSelectedItem = isSelected
        }
        cell.delegte = self
        return cell
    }
}

extension HealthConcernsViewController: HealthConcernsCollectionViewCellProtocol {
    
    func toAdd(index: Int, HearthConcerns: HearthConcernsModelData) {
        let filter = selectedData.filter { data in
            return data.id == HearthConcerns.id
        }
        if filter.isEmpty {
            healthConcerns?[index].isSelected = true
            selectedData.append(HearthConcerns)
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            tableView.reloadData()
        } else {
            healthConcerns?[index].isSelected = false
            let name = healthConcerns?[index].name
            let foundIndex = selectedData.firstIndex(where: { data in
                if data.name == name {
                    return true
                }
                return false
            }) ?? 0
            selectedData.remove(at: foundIndex)
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            tableView.reloadData()
        }
    }
}

extension HealthConcernsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReuseCell(type: HealthConcernsTableViewCell.self, indexPath: indexPath)
        cell.nameLabel.text = selectedData[indexPath.row].name
        return cell
    }
}
