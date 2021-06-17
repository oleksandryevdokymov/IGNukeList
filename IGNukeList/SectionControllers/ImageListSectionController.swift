//
//  ImageListSectionController.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 09.06.2021.
//

import Foundation
import IGListKit

protocol ImageListDelegate: AnyObject {
    func didSelectItem()
}

final class ImageListSectionController: ListBindingSectionController<ImageList>,
                                   ListBindingSectionControllerDataSource {

    let cellSpacing: CGFloat = 1
    let columns: CGFloat = 3
    
    weak var delegate: ImageListDelegate?

    override init() {
        super.init()
        dataSource = self
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }

    // MARK: - ListBindingSectionControllerDataSource
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                           viewModelsFor object: Any) -> [ListDiffable] {
        guard let object = object as? ImageList else { fatalError() }
        // decomposing ImageData into small ViewModels
        var results: [ListDiffable] = []
        for image in object.imageList {
            results.append(ImageListViewModel(image: image))
        }
        return results
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {

        guard let collectionContext = collectionContext else { fatalError() }

        return collectionContext.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as! ImageCell
    }


    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {

        guard let collectionContext = collectionContext else { fatalError() }

        let emptySpace = collectionContext.containerInset.left + collectionContext.containerInset.right + (columns * cellSpacing - 1)
        let cellSize = (collectionContext.containerSize.width - emptySpace) / columns

        return CGSize(width: cellSize, height: cellSize)
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.didSelectItem()
    }

}

