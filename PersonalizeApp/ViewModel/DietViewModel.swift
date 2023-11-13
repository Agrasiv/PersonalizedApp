//
//  DietViewModel.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import Combine

class DietViewModel: BaseViewModel {
    
    let getDietsList = CurrentValueSubject<[DietsModelData], Never>([DietsModelData]())
    
    func getDietsData() {
        let sub = readLocalJSONFile(forName: "Diets")
        sub.publisher.sink { [weak self] data in
            do {
                let dataResponse = try JSONDecoder().decode(DietsModel.self, from: data)
                self?.getDietsList.send(dataResponse.data)
            } catch(let error) {
                print(error)
                self?.isDecodeError.send("Decode Error")
            }
        }
        .store(in: &bindings)
    }
}
