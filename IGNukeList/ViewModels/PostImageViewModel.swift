//
//  PostImageViewModel.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 08.06.2021.
//

import Foundation
import IGListKit

final class PostImageViewModel: ListDiffable {
    let postImage: URL
    
    init(postImage: URL) {
        self.postImage = postImage
    }
    
    // MARK: - ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        // return "photo" as NSObjectProtocol
        return String("\(postImage.absoluteString)") as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? PostImageViewModel else { return false }
        return postImage == object.postImage
    }
}
