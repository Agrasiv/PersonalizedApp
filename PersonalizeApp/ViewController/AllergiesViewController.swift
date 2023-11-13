//
//  AllergiesViewController.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import UIKit
import Combine

class AllergiesViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var bindings = Set<AnyCancellable>()
    var viewModel = AllergiesViewModel()
    var isSearching: Bool = false
    var hearthConcernsList: [HearthConcernsModelData] = []
    var dietsList: [DietsModelData] = []
    var allergiesList: [AllergiesModelData] = []
    var searchResult: [AllergiesModelData] = []
    var selectedData: [AllergiesModelData] = []
    var totalTime = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUptableView()
        getAllergiesList()
        getProgressBar()
        textField.delegate = self
        if selectedData.count <= 0 {
            heightConstraint.constant = 0
        }
    }
    
    func setUptableView() {
        tableView.registerForCells(cells: AllergiesTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpCollectionView() {
        collectionView.registerForCells(cells: HealthConcernsCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = TagsLayout()
        collectionView.collectionViewLayout = layout
        view.layoutIfNeeded()
    }
    
    func getProgressBar() {
        progressBar.progress = Float(totalTime - 1) / Float(totalTime)
    }
    
    func getAllergiesList() {
        viewModel.getAllergiesData()
        
        viewModel.getAllergiesList.sink { [weak self] allergiesList in
            self?.allergiesList = allergiesList
            self?.tableView.reloadData()
        }
        .store(in: &bindings)
    }
    
    @IBAction func didTappedBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func didTappedNext(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "LastPageViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LastPageViewController") as! LastPageViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hearthConcernsList = hearthConcernsList
        vc.dietsList = dietsList
        vc.alliergiesList = selectedData
        self.present(vc, animated: false)
    }
}

extension AllergiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReuseCell(type: AllergiesTableViewCell.self, indexPath: indexPath)
        cell.nameLabel.text = searchResult[indexPath.row].name
        cell.index = indexPath.row
        cell.allergies = searchResult[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension AllergiesViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        self.isSearching = updatedText.count > 0
        searchResult = allergiesList.filter {
            return $0.name.uppercased().contains(updatedText.uppercased())
        }
        isEmptyOrHaveData(isSearching: self.isSearching)
        return true
    }
    
    func isEmptyOrHaveData(isSearching: Bool) {
        if isSearching {
            tableView.isHidden = searchResult.isEmpty ? true : false
        }
        tableView.reloadData()
    }
}

extension AllergiesViewController: AllergiesTableViewCellProtocol {
    
    func toAdd(index: Int, allergies: AllergiesModelData) {
        let filter = selectedData.filter { data in
            return data.id == allergies.id
        }
        if filter.isEmpty {
            selectedData.append(allergies)
            let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
            if heightConstraint.constant > UIScreen.main.bounds.size.height * 0.2  {
                self.heightConstraint.constant = UIScreen.main.bounds.size.height * 0.2
            }
            if heightConstraint.constant < UIScreen.main.bounds.size.height * 0.2  {
                self.heightConstraint.constant = height + 60
                self.view.layoutIfNeeded()
            }
            collectionView.reloadData()
        }
    }
}

extension AllergiesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReuseCell(type: HealthConcernsCollectionViewCell.self, indexPath: indexPath)
        cell.labelName.text = selectedData[indexPath.row].name
        cell.labelName.textColor = .white
        cell.bgView.backgroundColor = UIColor.primaryColor
        return cell
    }
}
 
