//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Eduardo Hanón on 5/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

class RecordedAudio
{
    var filePathUrl: NSURL!
    var title: String!
    init(filePathUrl : NSURL!, title: String!)
    {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}


