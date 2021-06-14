//
//  HistoryModel.swift
//  MiniChallenge2
//
//  Created by Christian Adiputra on 14/06/21.
//

import Foundation
class HistoryModel {
    
    var name: String
    var thumbnailImage: String
    var category: String
    var date: String
    var time: String
    var score: String
    
    
    init(name:String, thumbnailImage:String, category: String, time: String, score: String, date: String ) {
        self.name = name;
        self.thumbnailImage = thumbnailImage;
        self.category = category;
        self.date = date;
        self.score = score;
        self.time = time
    }
}
