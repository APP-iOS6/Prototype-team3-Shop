//
//  OOTDItem.swift
//  OOTD_Team3
//
//  Created by wonhoKim on 8/27/24.
//

import Foundation

enum Style: String, CaseIterable {
    case geekSik = "#긱시크"
    case street = "#스트릿"
    case casual = "#캐주얼"
   
}

struct Item {
    var style: Style
    var itemImage: String
       
}
