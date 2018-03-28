//
//  FeedViewController.swift
//  YouTMusic
//
//  Created by Huy Nguyễn on 3/27/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Cocoa
import YouTMusicCore

fileprivate let CellIdentifier: String = "NewestSongCell"

class FeedViewController: BaseViewController {
    
    //    MARK: - OUTLET
    @IBOutlet weak var collectionView: YouTMusicCollectionView!
    
    //    MARK: - Variable
    fileprivate var newestSongObjs: [SongObj]!
    

    //    MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        
    //    Update
        
        guard let currentUser = YouTMusicOAuth.shareInstance.currentUserObj else { return }
        guard let newestSongObjs = currentUser.newestSongsMethodObjVar.value else { return }
        
        self.newestSongObjs = newestSongObjs
        collectionView.reloadData()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    deinit {
        NotificationCenter.removeAllObserver(self)
    }
    
    fileprivate func binding() {
        
    }
}

// MARK: - Private
extension FeedViewController {
    
    fileprivate func initCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.allowsMultipleSelection = false
        collectionView.allowsEmptySelection = false
        
        let nib = NSNib(nibNamed: NSNib.Name(rawValue: CellIdentifier), bundle: nil)
        collectionView.register(nib, forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(CellIdentifier))
    }
}

extension FeedViewController: NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return newestSongObjs.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifier), for: indexPath) as? NewestSongCell else {
            return NSCollectionViewItem()
        }
        cell.configure(with: newestSongObjs[indexPath.item])
        return cell
    }
}

extension FeedViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        // TODO
    }
}
