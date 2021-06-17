//
//  ViewController.swift
//  IGNukeList
//
//  Created by Oleksandr Yevdokymov on 08.06.2021.
//

import UIKit
import IGListKit
import Nuke

class ViewController: UIViewController, ListAdapterDataSource {
    // IGListPropertise
    var photoURLs: [URL] = []
    
    var data = [ListDiffable]()
    var post: Post?
    var imageList: [URL] = []
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .black
        return view
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(),
                           viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotoURLs()
        
        appendPostData()
        appendImageListData()
        
        let nibCell = UINib(nibName: "ActionCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "action")
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        // Nuke
        setupPlaceholdersAndContentModes()
        setupCachingImages()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    
    private func appendImageListData() {
        let imageList = Array(photoURLs[4..<photoURLs.count])
        data.append(ImageList(imageList: imageList))
        self.imageList = imageList
    }
    
    private func fetchPhotoURLs() {
        guard let plist = Bundle.main.url(forResource: "NASAPhotos", withExtension: "plist"),
              let contents = try? Data(contentsOf: plist),
              let plistSerialized = try? PropertyListSerialization.propertyList(from: contents, options: [], format: nil),
              let urlPaths = plistSerialized as? [String] else {
            return
        }
        photoURLs = urlPaths.compactMap { URL(string: $0) }
        print(photoURLs.count)
    }
    
    // MARK: - Nuke setup methods
    private func setupPlaceholdersAndContentModes() {
        let contentModes = ImageLoadingOptions.ContentModes(success: .scaleToFill,
                                                            failure: .scaleToFill,
                                                            placeholder: .scaleToFill)
        ImageLoadingOptions.shared.contentModes = contentModes
        ImageLoadingOptions.shared.placeholder = UIImage(named: "dark-moon")
        ImageLoadingOptions.shared.failureImage = UIImage(named: "annoyed")
        ImageLoadingOptions.shared.transition = .fadeIn(duration: 0.5)
    }
    
    private func setupCachingImages() {
        DataLoader.sharedUrlCache.diskCapacity = 0
        let pipeline = ImagePipeline {
          let dataCache = try? DataCache(name: "com.raywenderlich.Far-Out-Photos.datacache")
          dataCache?.sizeLimit = 200 * 1024 * 1024
          $0.dataCache = dataCache
        }
        
        ImagePipeline.shared = pipeline
    }
    
    private func appendPostData() {
        data = []
        let postImages = Array(photoURLs[0...3])
        let post = Post(postImages: postImages, rotateLeftAction: 0, rotateRightAction: 0)
        data.append(post)
        self.post = post
    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is Post {
            let postSectionController = PostSectionController()
            postSectionController.delegate = self
            return postSectionController
        } else {
            let imageListSectionController = ImageListSectionController()
            imageListSectionController.delegate = self
            return imageListSectionController
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// MARK: - PostSectionDelegate
extension ViewController: PostSectionDelegate {
    func didTapLeftRotate() {
        data = []
        guard let post = post else { return }
        
        let postImages = post.postImages
        let newPostImages = [postImages[1], postImages[3], postImages[0], postImages[2]]
        
        let postRotateLeftAction = post.rotateLeftAction + 1
        let updatedPost = Post(postImages: newPostImages, rotateLeftAction: postRotateLeftAction, rotateRightAction: post.rotateRightAction)
        data.append(updatedPost)
        self.post = updatedPost
        appendImageListData()
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    func didTapRightRotate() {
        data = []
        guard let post = post else { return }
        
        let postImages = post.postImages
        let newPostImages = [postImages[2], postImages[0], postImages[3], postImages[1]]
        
        let postRotateRightAction = post.rotateRightAction + 1
        let updatedPost = Post(postImages: newPostImages, rotateLeftAction: post.rotateLeftAction, rotateRightAction: postRotateRightAction)
        data.append(updatedPost)
        self.post = updatedPost
        appendImageListData()
        adapter.performUpdates(animated: true, completion: nil)
    }

    func didSelectPostItem() {
        data = []
        guard let post = post else { return }
        var newPostImages: [URL] = post.postImages
        newPostImages.append(photoURLs.randomElement() ?? photoURLs[5])
        let updatedPost = Post(postImages: newPostImages, rotateLeftAction: post.rotateLeftAction, rotateRightAction: post.rotateRightAction)
        data.append(updatedPost)
        self.post = updatedPost
        appendImageListData()
        adapter.performUpdates(animated: true, completion: nil)
    }
}

// MARK: - ImageListDelegate
extension ViewController: ImageListDelegate {
    func didSelectItem() {
        guard let post = post else { return }
        data = []
        data.append(post)
        imageList.shuffle()
        data.append(ImageList(imageList: imageList))
        adapter.performUpdates(animated: true, completion: nil)
    }
}

