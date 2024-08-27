//
//  OOTDItemStore.swift
//  OOTD_Team3
//
//  Created by wonhoKim on 8/27/24.
//

import Foundation
class ItemStore {
    static let shared = ItemStore()
    
    var items: [Item] = []
    
    init() {
        items = [
            Item(style: .geekSik, itemImage: "긱시크1"),
            Item(style: .geekSik, itemImage: "긱시크2"),
            Item(style: .geekSik, itemImage: "긱시크3"),
            Item(style: .geekSik, itemImage: "1"),
            Item(style: .geekSik, itemImage: "2"),
            Item(style: .geekSik, itemImage: "3"),
            Item(style: .geekSik, itemImage: "4"),
            Item(style: .geekSik, itemImage: "5"),
            Item(style: .geekSik, itemImage: "6"),
            Item(style: .street, itemImage: "스트릿1"),
            Item(style: .street, itemImage: "스트릿2"),
            Item(style: .street, itemImage: "스트릿3"),
            Item(style: .street, itemImage: "스트릿4"),
            Item(style: .street, itemImage: "스트릿5"),
            Item(style: .street, itemImage: "스트릿6"),
            Item(style: .street, itemImage: "스트릿7"),
            Item(style: .street, itemImage: "스트릿8"),
            Item(style: .street, itemImage: "스트릿9"),
            Item(style: .casual, itemImage: "긱시크1"),
            Item(style: .casual, itemImage: "긱시크2"),
            Item(style: .casual, itemImage: "긱시크3"),
            Item(style: .casual, itemImage: "1"),
            Item(style: .casual, itemImage: "2"),
            Item(style: .casual, itemImage: "3"),
            Item(style: .casual, itemImage: "4"),
            Item(style: .casual, itemImage: "5"),
            Item(style: .casual, itemImage: "6"),
            
        ]
    }
    
}
