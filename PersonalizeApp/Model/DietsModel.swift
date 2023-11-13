//
//  DietsModel.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation

struct DietsModel: Codable {
    let data: [DietsModelData]
}

struct DietsModelData: Codable {
    let id: Int
    let name: String
    let tool_tip: String
}
