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

struct Test {
    let title: String
    let subtitle: String
    let desc: String
    let imageIcon: UIImage
    
}

class DummyData {
    static let shared = DummyData()
    
    let dummyTest: [Test] = [
        Test(
            title: "Cardio",
            subtitle: "1,6 km run",
            desc: "You will endure a cardio test \nin the form of a 1.6 km run.\nThe app will track your mile,\ncalculate your VO2max \nand determine how far\nyou have progressed.\nRun fast and exceed your limit.",
            imageIcon: #imageLiteral(resourceName: "paru")
        ),
        Test(
            title: "Strength",
            subtitle: "2 min test",
            desc: "There will be 3 categories\nthat we will measure,\nthere are Upper Body,\nLower Body and Core.\nThere will be a total of 6 exercises\neach done in 2 minutes.\nWe wish you to go beyond your limits.",
            imageIcon: #imageLiteral(resourceName: "muscle")
        )
    ]
    
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
