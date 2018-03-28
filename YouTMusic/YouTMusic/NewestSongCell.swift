//
//  NewestSongCell.swift
//  YouTMusic
//
//  Created by Huy Nguyễn on 3/27/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Cocoa
import YouTMusicCore

class NewestSongCell: NSCollectionViewItem {
    
    @IBOutlet weak var thumbnailImg: NSImageView!
    @IBOutlet weak var titleLbl: NSTextField!
    @IBOutlet weak var singerLbl: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    public func configure(with songObj: SongObj) {
        titleLbl.stringValue = songObj.title
        singerLbl.stringValue = songObj.singer
        thumbnailImg.image = NSImage(byReferencing: URL(string: songObj.thumbnail._default.url)!)
    }
}
