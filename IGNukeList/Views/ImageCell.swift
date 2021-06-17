//
//  ImageCell.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 08.06.2021.
//

import UIKit
import IGListKit
import Nuke

class ImageCell: UICollectionViewCell, ListBindable {
    
    var imageView: UIImageView = UIImageView()
    
    // MARK: - Nuke properties
    var pixelSize: CGFloat {
        return bounds.width * UIScreen.main.scale
    }
    
    var resizedImageProcessors: [ImageProcessing] {
        let imageSize = CGSize(width: pixelSize, height: pixelSize)
        return [ImageProcessors.Resize(size: imageSize, contentMode: .aspectFill)]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        backgroundColor = .gray
    }
    
    // MARK: - ListBindable
    func bindViewModel(_ viewModel: Any) {
        if let viewModel = viewModel as? PostImageViewModel {
            let request = ImageRequest(url: viewModel.postImage,
                                       processors: resizedImageProcessors)
            Nuke.loadImage(with: request, into: imageView)
        } else if let viewModel = viewModel as? ImageListViewModel {
            let request = ImageRequest(url: viewModel.image,
                                       processors: resizedImageProcessors)
            Nuke.loadImage(with: request, into: imageView)
        } else {
            fatalError()
        }
    }
}
