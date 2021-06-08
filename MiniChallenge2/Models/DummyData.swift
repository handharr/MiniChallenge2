//
//  DummyData.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 07/06/21.
//

import Foundation
import UIKit

struct Plan {
    let name: String
    let description: String
    let workoutPerDay: Int
    let daysPerWeek: Int
    let onGoing: Bool
    let planImage: UIImage
}

class DummyData {
    static let shared = DummyData()
    
    let dummyPlan: [Plan] = [
        Plan(
            name: "All in One Plan",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sit vitae, justo, eu, blandit parturient. Et ut purus viverra vestibulum id at a.",
            workoutPerDay: 4,
            daysPerWeek: 2,
            onGoing: true,
            planImage: UIImage(named: "plan-image-1")!
        ),
        Plan(
            name: "Cardiovascular Plan",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sit vitae, justo, eu, blandit parturient. Et ut purus viverra vestibulum id at a.",
            workoutPerDay: 4,
            daysPerWeek: 2,
            onGoing: false,
            planImage: UIImage(named: "plan-image-3")!
        ),
        Plan(
            name: "Strength Plan",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sit vitae, justo, eu, blandit parturient. Et ut purus viverra vestibulum id at a.",
            workoutPerDay: 4,
            daysPerWeek: 2,
            onGoing: false,
            planImage: UIImage(named: "plan-image-2")!
        )
    ]
    
    public func getOnGoing() -> Plan? {
        
        if let index = dummyPlan.firstIndex(where: { $0.onGoing == true }) {
            return dummyPlan[index]
        }
        
        return nil
    }
    
    public func getOtherPlan() -> [Plan] {
        let filtered = dummyPlan.filter { $0.onGoing == false }
        
        return filtered
    }
}
