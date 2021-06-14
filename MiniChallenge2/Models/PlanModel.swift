//
//  PlanModel.swift
//  MiniChallenge2
//
//  Created by Christian Adiputra on 14/06/21.
//

import Foundation
class PlanModel {
    
    var name: String
    var thumbnailImage: String
    var desc: String
    var workoutPerDay: Int
    var daysPerWeek: Int
    var onGoing: String
    
    
    init(desc:String, name:String, thumbnailImage:String, workoutPerDay: Int, daysPerWeek: Int, onGoing: String ) {
        self.desc = desc;
        self.name = name;
        self.thumbnailImage = thumbnailImage;
        self.workoutPerDay = workoutPerDay;
        self.daysPerWeek = daysPerWeek;
        self.onGoing = onGoing
    }
}
