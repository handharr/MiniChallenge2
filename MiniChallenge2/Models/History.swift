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
    
    func calculateVO2Max() -> String{
        switch self{
        case .cardio:
            return "31.7"
        case .upperBody:
            return "31.7"
        case .lowerBody:
            return "31.7"
        case .core:
            return "31.7"
        case .strength:
            return "31.7"
        }
    }
}

struct History{
    private let id: String = UUID().uuidString
    var evaluationType : evaluationType?
    var time: String?
    var date : String = ""
    
    public static var data = [History]()
    
    init(evaluationType: evaluationType, time: String?) {
        self.date = dateFormatter()
        self.evaluationType = evaluationType
        self.time = time
    }
    
    private func dateFormatter() -> String{
        let todayDate = Date()
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yy"
        
        return dateFormatterGet.string(from: todayDate)
    }
    
    static func getData() -> [History]{
        return data
    }
    
    static func addData(newData: History){
        data.append(newData)
    }
    
}
