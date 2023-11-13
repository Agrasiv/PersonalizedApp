//
//  HealthConcernsViewModel.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import Combine

class HealthConcernsViewModel: BaseViewModel {
    
    let getHealthConcernsList = CurrentValueSubject<[HearthConcernsModelData], Never>([HearthConcernsModelData]())
    
    func getHealthConcernsData() {
        let sub = readLocalJSONFile(forName: "Healthconcern")
        sub.publisher.sink { [weak self] data in
            do {
                let dataResponse = try JSONDecoder().decode(HearthConcernsModel.self, from: data)
                self?.getHealthConcernsList.send(dataResponse.data)
            } catch(let error) {
                print(error)
                self?.isDecodeError.send("Decode Error")
            }
        }
        .store(in: &bindings)

    }
}
