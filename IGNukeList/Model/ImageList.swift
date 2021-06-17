//
//  ImageList.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 09.06.2021.
//

import Foundation
import IGListKit

final class ImageList: NSObject, ListDiffable {
    let imageList: [URL]
    
    init(imageList: [URL]) {
        self.imageList = imageList
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return self as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ImageList else { return false }
        return imageList == object.imageList
    }
}
