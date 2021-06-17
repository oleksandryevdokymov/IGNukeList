//
//  ActionCell.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 08.06.2021.
//

import UIKit
import IGListKit

protocol ActionCellDelegate: AnyObject {
    func didTapLeftRotate(cell: ActionCell)
    func didTapRightRotate(cell: ActionCell)
}

class ActionCell: UICollectionViewCell, ListBindable {

    @IBOutlet var leftRotationLabel: UILabel!
    @IBOutlet var leftRotationButton: UIButton!
    @IBOutlet var rightRotationLabel: UILabel!
    @IBOutlet var rightRotationButton: UIButton!
    
    weak var delegate: ActionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leftRotationButton.addTarget(self, action: #selector(ActionCell.onLeftRotate), for: .touchUpInside)
        rightRotationButton.addTarget(self, action: #selector(ActionCell.onRightRotate), for: .touchUpInside)
    }
    
    @objc func onLeftRotate() {
        delegate?.didTapLeftRotate(cell: self)
    }
    
    @objc func onRightRotate() {
        delegate?.didTapRightRotate(cell: self)
    }
    
    // MARK: - ListBindable
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? ActionViewModel else { return }
        leftRotationLabel.text = "\(viewModel.leftRotates)"
        rightRotationLabel.text = "\(viewModel.rightRotates)"
    }

}
