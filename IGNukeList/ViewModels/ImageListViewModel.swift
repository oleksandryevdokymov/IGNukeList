//
//  ImageListViewModel.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 08.06.2021.
//

import Foundation
import IGListKit
 
final class ImageListViewModel: NSObject, ListDiffable {
    let image: URL
    
    init(image: URL) {
        self.image = image
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return image as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ImageListViewModel else { return false }
        return image == object.image
    }
}
