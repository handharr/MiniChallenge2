//
//  PaketModel.swift
//  MiniChallenge2
//
//  Created by Christian Adiputra on 15/06/21.
//

import Foundation

class PaketModel {
    
//  var exercises: [ExerciseModel]
    var status: Bool
    var total: Int
    var level: Int
    var minutes: Int
    var set: Int
    
    init(status: Bool, total: Int, level: Int, minutes: Int, set: Int) {
        self.status = status;
        self.total = total;
        self.level = level;
        self.minutes = minutes
        self.set = set
    }
    
    //get total minutes
//    func getMinute() -> Int {
//        var temp = 0
//
//        for item in exercises {
//            temp += item.time
//        }
//        return temp
//    }
    
}
