//
//  ActionViewModel.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 08.06.2021.
//

import Foundation
import IGListKit

final class ActionViewModel: ListDiffable {
    let leftRotates: Int
    let rightRotates: Int
    
    init(leftRotates: Int, rightRotates: Int) {
        self.leftRotates = leftRotates
        self.rightRotates = rightRotates
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        // This will enforce only a single model & cell being used.
        return "action" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ActionViewModel else { return false }
        return leftRotates == object.leftRotates &&
            rightRotates == object.rightRotates
    }
}
