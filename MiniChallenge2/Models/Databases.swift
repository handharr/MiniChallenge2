//
//  Databases.swift
//  MiniChallenge2
//
//  Created by Christian Adiputra on 14/06/21.
//


import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import Firebase


class Databases {
    static let shared = Databases()
    
    var ref:DatabaseReference?
    var plans = [PlanModel]()
    var histories = [HistoryModel]()
    
    
    init() {
        retrivePlan()
        print("ini plan ya \(plans)")
    }
    
}

extension Databases{
    
    //MARK: - Retrive Data Plan
    func retrivePlan(){
        ref = Database.database().reference().child("plan")
        ref?.observe(.value, with: { (snapshot) in
            if snapshot.childrenCount>0{
                self.plans.removeAll()
                for plans in snapshot.children.allObjects as![DataSnapshot]{
                    let planObject =  plans.value as? [String: Any]
                    let planName =  planObject?["name"]
                    let planDesc = planObject?["desc"]
                    let planThumbnail = planObject?["thumbnail"]
                    let planWPD = planObject?["wpd"]
                    let planDPW = planObject?["dpw"]
                    let planOG = planObject?["ongoing"]
                    let planCategory = planObject?["category"]
                    
                    let plan = PlanModel(desc: planDesc as! String, name: planName as! String, thumbnailImage: planThumbnail as! String, workoutPerDay: planWPD as! Int, daysPerWeek: planDPW as! Int, onGoing: planOG as! Bool, category: planCategory as! String)
                    self.plans.append(plan)
                    print("ini ya plan \(plan.name)")
                    print(self.plans.count)
                }
                //self.exerciseTV.reloadData()
                //print("total \(self.plans.count)")
            }
        })
    }
    
    //MARK: - Retrive data History
    func retriveHistory(){
        ref = Database.database().reference().child("history")
        ref?.observe(.value, with: { (snapshot) in
            if snapshot.childrenCount>0{
                self.plans.removeAll()
                for histories in snapshot.children.allObjects as![DataSnapshot]{
                    let historyObject =  histories.value as? [String: Any]
                    let historyName = historyObject?["name"]
                    let historyThumbnail = historyObject?["thumbnailImage"]
                    let category = historyObject?["category"]
                    let date = historyObject?["date"]
                    let time = historyObject?["time"]
                    let score = historyObject?["score"]
                    
                    let history = HistoryModel(name: historyName as! String, thumbnailImage: historyThumbnail as! String, category: category as! String, time: time as! String, score: score as! String, date: date as! String)
                    self.histories.append(history)
                    print()
                }
                //self.exerciseTV.reloadData()
                print("total \(self.histories.count)")
            }
        })
    }
    
    //MARK: - getImage for MyPlan
    
//    func getImage(cell: PlanTableViewCell, plan: PlanModel){
//        DispatchQueue.global(qos: .background).async {
//            DispatchQueue.main.async {
//                if (plan.thumbnailImage != nil){
//                    let storageRef = Storage.storage().reference(withPath: "plan/\(plan.thumbnailImage ?? "tb1")")
//                    storageRef.getData(maxSize: 4 * 1024 * 1024){ [weak self] (data, error) in
//                        if let error = error {
//                            print("Got an error: \(error.localizedDescription)")
//                            return
//                        }
//                        if let data = data {
//                            cell.imagePlan.image = UIImage(data: data)
//                        }
//                    }
//                }
//            }
//        }
//    }
    
//        func getImage(path: String) -> UIImage?{
//            var image: UIImage?
//            DispatchQueue.global(qos: .background).async {
//                DispatchQueue.main.async {
//                    let storageRef = Storage.storage().reference(withPath: path)
//
//                    storageRef.getData(maxSize: 4 * 1024 * 1024){ (data, error) in
//                        if let error = error {
//                            print("Got an error: \(error.localizedDescription)")
//                            return
//                        }
//                        guard let data = data else {return}
//                        image = UIImage(data: data)
//                    }
//                }
//            }
//            guard let image = image else {return nil}
//            return image
//        }

    
    //MARK: - add History Data
    func addHistory(){
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        let dateTimeString = formatter.string(from: currentDateTime)
        
        
        let object: [String:Any] = [
            "name": "Cardio" as NSObject,
            "score":"\(Int.random(in: 10..<100))",
            "category": "Need Work",
            "date": dateTimeString,
            "time": "120",
            "thumbnail" : "Plan1.png"
        ]
        
        
        let newHis = Database.database().reference()
        newHis.child("history").childByAutoId().setValue(object)
    }
    
    //MARK: - updatePlan Status
    
    func updatePlanStatus(planid: String,planName: String, planDesc: String, imgThumbnail: String, onGoing: String, workoutperday: Int, dayperweek: Int, category: String) {
        let plan = [
            "name" : planName,
            "desc" : planDesc,
            "category" : category,
            "thumbnail" : imgThumbnail,
            "ongoing" : onGoing,
            "dpw" : dayperweek,
            "wpd" : workoutperday
        ] as [String : Any]
        
        ref = Database.database().reference().child(planid)
        ref?.setValue(plan)
        //ref?.child()
        
    }
}
//MARK: - Get Data
 extension Databases {
    
    func getBeginnerPlan() -> [PlanModel] {
        return plans.filter {$0.category == "beginner"}
    }
    func getIntermediatePlan() -> [PlanModel] {
        return plans.filter {$0.category == "intermediate"}
    }
    func getAdvancePlan() -> [PlanModel] {
        return plans.filter {$0.category == "advance"}
    }
    
    public func getOnGoing() -> PlanModel? {
        
        if let index = plans.firstIndex(where: { $0.onGoing == true }) {
            return plans[index]
        }
        
        return nil
    }
}
