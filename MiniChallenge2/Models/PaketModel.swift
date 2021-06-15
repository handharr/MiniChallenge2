//
//  PaketModel.swift
//  MiniChallenge2
//
//  Created by Christian Adiputra on 15/06/21.
//

import Foundation

class PaketModel {
    
    var exercises: [ExerciseModel]
    var status: String
    var total: Int
    var level: Int

    
    init(exercises: [ExerciseModel], status: String, total: Int, level: Int) {
        self.exercises = exercises;
        self.status = status;
        self.total = total;
        self.level = level
    }
    
    func getMinute() -> Int {
        var temp = 0
        
        for item in exercises {
            temp += item.time
        }
        return temp
    }
    
}
