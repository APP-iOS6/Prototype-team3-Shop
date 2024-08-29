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
            Item(style: .geekSik, itemImage: "gikSik1"),
            Item(style: .geekSik, itemImage: "gikSik2"),
            Item(style: .geekSik, itemImage: "gikSik3"),
            Item(style: .geekSik, itemImage: "gikSik4"),
            Item(style: .geekSik, itemImage: "gikSik5"),
            Item(style: .geekSik, itemImage: "gikSik6"),
            Item(style: .geekSik, itemImage: "gikSik7"),
            Item(style: .geekSik, itemImage: "gikSik8"),
            Item(style: .geekSik, itemImage: "gikSik9"),
            Item(style: .street, itemImage: "street1"),
            Item(style: .street, itemImage: "street2"),
            Item(style: .street, itemImage: "street3"),
            Item(style: .street, itemImage: "street4"),
            Item(style: .street, itemImage: "street5"),
            Item(style: .street, itemImage: "street6"),
            Item(style: .street, itemImage: "street7"),
            Item(style: .street, itemImage: "street8"),
            Item(style: .street, itemImage: "street9"),
            Item(style: .casual, itemImage: "casual1"),
            Item(style: .casual, itemImage: "casual2"),
            Item(style: .casual, itemImage: "casual3"),
            Item(style: .casual, itemImage: "casual4"),
            Item(style: .casual, itemImage: "casual5"),
            Item(style: .casual, itemImage: "casual6"),
            Item(style: .casual, itemImage: "casual7"),
            Item(style: .casual, itemImage: "casual8"),
            Item(style: .casual, itemImage: "casual9"),
            
        ]
    }
    
}
