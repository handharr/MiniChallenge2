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
                    let planThumbnail = planObject?["thumbnailImage"]
                    let planWPD = planObject?["workoutPerDay"]
                    let planDPW = planObject?["dpw"]
                    let planOG = planObject?["onGoing"]
                    
                    let plan = PlanModel(desc: planDesc as! String, name: planName as! String, thumbnailImage: planThumbnail as! String, workoutPerDay: planWPD as! Int, daysPerWeek: planDPW as! Int, onGoing: planOG as! String)
                    self.plans.append(plan)
                    print()
                }
                //self.exerciseTV.reloadData()
                print("total \(self.plans.count)")
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
