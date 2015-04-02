//
//  RecordedAudio.swift
//  Phil's Pitch Perfect!
//
//  Created by Phillip Hughes on 02/04/2015.
//  Copyright (c) 2015 Phillip Hughes. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}