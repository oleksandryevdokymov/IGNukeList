//
//  PostSectionController.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 08.06.2021.
//

import Foundation
import IGListKit

protocol PostSectionDelegate: AnyObject {
    func didTapLeftRotate()
    func didTapRightRotate()
    func didSelectPostItem()
}

final class PostSectionController: ListBindingSectionController<Post>,
                                   ListBindingSectionControllerDataSource, ActionCellDelegate {
    
    weak var delegate: PostSectionDelegate?
    
    override init() {
        super.init()
        dataSource = self
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
    
    // MARK: - ListBindingSectionControllerDataSource
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                           viewModelsFor object: Any) -> [ListDiffable] {
        guard let object = object as? Post else { fatalError() }
        // decomposing ImageData into small ViewModels
        var results: [ListDiffable] = []
        results.append(ActionViewModel(leftRotates: object.rotateLeftAction, rightRotates: object.rotateRightAction))
        for image in object.postImages {
            results.append(PostImageViewModel(postImage: image))
        }
        return results
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {
        
        guard let collectionContext = collectionContext else { fatalError() }
        
        let cell: UICollectionViewCell & ListBindable
        
        switch viewModel {
        case is ActionViewModel:
            cell = collectionContext.dequeueReusableCellFromStoryboard(withIdentifier: "action", for: self, at: index) as! UICollectionViewCell & ListBindable
        case is PostImageViewModel:
            cell = collectionContext.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as! ImageCell
        default:
            fatalError()
            break
        }
        
        if let cell = cell as? ActionCell {
            cell.delegate = self
        }
        
        return cell
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        
        guard let collectionContext = collectionContext else { fatalError() }
        
        let cellSize: CGFloat = collectionContext.containerSize.width / 2
        
        
        switch viewModel {
        case is ActionViewModel:
            return CGSize(width: collectionContext.containerSize.width, height: 55)
        case is PostImageViewModel:
            return CGSize(width: cellSize, height: cellSize)
        default:
            fatalError()
            break
        }
    }
    
    // MARK: - ActionCellDelegate
    override func didSelectItem(at index: Int) {
        delegate?.didSelectPostItem()
    }
    
    
    func didTapLeftRotate(cell: ActionCell) {
        delegate?.didTapLeftRotate()
    }
    
    func didTapRightRotate(cell: ActionCell) {
        delegate?.didTapRightRotate()
    }
    
}

