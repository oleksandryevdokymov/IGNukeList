//
//  ImageList.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 08.06.2021.
//

import Foundation
import IGListKit

final class Post: NSObject, ListDiffable {
    let postImages: [URL]
    let rotateLeftAction: Int
    let rotateRightAction: Int
    
    init(postImages: [URL],
         rotateLeftAction: Int,
         rotateRightAction: Int) {
        self.postImages = postImages
        self.rotateLeftAction = rotateLeftAction
        self.rotateRightAction = rotateRightAction
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Post else { return false }
        return postImages == object.postImages
            && rotateLeftAction == object.rotateLeftAction
            && rotateRightAction == object.rotateRightAction
    }
}
