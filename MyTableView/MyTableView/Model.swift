//
//  Model.swift
//  MyTableView
//
//  Created by sangheon on 2022/02/04.
//

import Foundation

enum CellModel {
    case collectionView(models:[CollectionTableCellModel],rows: Int)
    case list(models:[ListCellModel])
}

struct ListCellModel {
    let title:String
}

struct CollectionTableCellModel {
    let title:String
    let imageName:String
}
