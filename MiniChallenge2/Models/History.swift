//
//  History.swift
//  EvaluationPage
//
//  Created by Jackie Leonardy on 07/06/21.
//

import UIKit

enum evaluationType: String, CaseIterable{
    case cardio = "Cardio"
    case upperBody = "Upper Body"
    case lowerBody = "Lower Body"
    case core = "Core"
    case strength = "Strength"
    
    func getPict() ->UIImage{
        switch self{
        case .cardio:
            return #imageLiteral(resourceName: "plan-image-1")
        case .upperBody:
            return #imageLiteral(resourceName: "plan-image-3")
        case .lowerBody:
            return #imageLiteral(resourceName: "plan-image-1")
        case .core:
            return #imageLiteral(resourceName: "plan-image-2")
        case .strength:
            return #imageLiteral(resourceName: "plan-image-2")
        }
    }
    
    func calculateResult() -> String{
        switch self{
        case .cardio:
            return "Need Work"
        case .upperBody:
            return "Excellent"
        case .lowerBody:
            return "Need Work"
        case .core:
            return "Need Work"
        case .strength:
            return "Excellent"
        }
    }
}

struct History{
    let id: String = UUID().uuidString
    var evaluationType : evaluationType?
    var resultValue: Int?
    var date : String = ""
    
    init(evaluationType: evaluationType, result: Int?) {
        self.date = dateFormatter()
        self.evaluationType = evaluationType
        resultValue = result
    }
    
    private func dateFormatter() -> String{
        let todayDate = Date()
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yy"
        
        return dateFormatterGet.string(from: todayDate)
    }
    
    static func getData() -> [History]{
        let data : [History] = [
            History(evaluationType: .cardio, result: 23),
            History(evaluationType: .core, result: 23),
            History(evaluationType: .lowerBody, result: 23),
            History(evaluationType: .upperBody, result: 23),
            History(evaluationType: .strength, result: 23),
            History(evaluationType: .upperBody, result: 23),
            History(evaluationType: .cardio, result: 23),
            History(evaluationType: .strength, result: 23),
            History(evaluationType: .core, result: 23),
            History(evaluationType: .upperBody, result: 23)
        ]
        return data
    }
    
}
