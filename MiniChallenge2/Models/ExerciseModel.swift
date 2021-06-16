//
//  ExerciseModel.swift
//  MiniChallenge2
//
//  Created by Christian Adiputra on 15/06/21.
//

import Foundation

class ExerciseModel {
    var name: String
    var thumbnailImage: String
    var video: String
    var time: Int
    var paketid: String
    var category: String
    
    init(name: String, thumbnail: String, video: String, time: Int, category: String, paketid: String) {
        self.name = name;
        self.thumbnailImage = thumbnail;
        self.video = video;
        self.time = time;
        self.category = category;
        self.paketid = paketid
    }
    
}
