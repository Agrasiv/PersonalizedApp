//
//  AllergiesViewModel.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import Combine

class AllergiesViewModel: BaseViewModel {
    
    let getAllergiesList = CurrentValueSubject<[AllergiesModelData], Never>([AllergiesModelData]())
    
    func getAllergiesData() {
        let sub = readLocalJSONFile(forName: "allergies")
        sub.publisher.sink { [weak self] data in
            do {
                let dataResponse = try JSONDecoder().decode(AllergiesModel.self, from: data)
                self?.getAllergiesList.send(dataResponse.data)
            } catch(let error) {
                print(error)
                self?.isDecodeError.send("Decode Error")
            }
        }
        .store(in: &bindings)
    }
}

