//
//  HealthModel.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 15/06/21.
//

import Foundation
import HealthKit

class HealthModel{
    
    public static var healthStore = HKHealthStore()
    static var hasRequestedHealthData: Bool = defaults.bool(forKey: "RequestedHealthData")
    private static var defaults = UserDefaults.standard
    
    static func setUpHealthRequest( navigating: @escaping () -> Void){
        if HKHealthStore.isHealthDataAvailable(){
            let infoToRead = Set([
                            HKSampleType.characteristicType(forIdentifier: .biologicalSex)!,
                            HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!,
                            HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
                            HKSampleType.quantityType (forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
                            HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
                            HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                            HKSampleType.quantityType(forIdentifier: .heartRate)!,
                            HKSampleType.workoutType()
                            ])
            let infoToWrite = Set([ HKObjectType.workoutType() ])
            healthStore.requestAuthorization(toShare: infoToWrite, read: infoToRead, completion: { (success, error) in
                
                if (error != nil) {
//                    labelText = "HealthKit Authorization Error: \(error.localizedDescription)"
                    hasRequestedHealthData = false
                } else {
                    if success {
                        if self.hasRequestedHealthData {
//                            labelText = "You've already requested access to health data. "
                        } else {
//                           labelText = "HealthKit authorization request was successful! "
                        }
                        defaults.set(true, forKey: "RequestedHealthData")
                        self.hasRequestedHealthData = defaults.bool(forKey: "RequestedHealthData")
                    } else {
                        defaults.set(false, forKey: "RequestedHealthData")
                        self.hasRequestedHealthData = defaults.bool(forKey: "RequestedHealthData")
                    }
                }
                readMostRecentSample()
                navigating()
                
            })
        }
    }
    
    static func getReadableBiologicalSex(biologicalSex: HKBiologicalSex?) -> String{
        var biologicalSexTest = "Not Retrived"
        
        if biologicalSex != nil {
            switch biologicalSex!.rawValue{
                case 0:
                    biologicalSexTest = ""
                case 1:
                    biologicalSexTest = "Female"
                case 2:
                    biologicalSexTest = "Male"
                case 3:
                    biologicalSexTest = "Other"
                default:
                    biologicalSexTest = ""
            }
        }
        
        return biologicalSexTest
    }
    
    private static func readData() -> (String, String){
        var age : Int?
        var sex : HKBiologicalSex?
        var sexData : String = "Not Retrived"
        do{
            let birthDay = try healthStore.dateOfBirthComponents()
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date() )
            age = currentYear - birthDay.year!
        }catch{}
        
        do{
            let getSex = try healthStore.biologicalSex()
            sex = getSex.biologicalSex
            if let data = sex {
                sexData = self.getReadableBiologicalSex(biologicalSex: data)
            }
        }catch{}
        
        return (age: String(age ?? 0), sex: sexData)
    }
    
    static func readMostRecentSample(){
        let weightType = HKSampleType.quantityType (forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let heightType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        
        var height : String = "Not Retrived"
        var weight : String = "Not Retrived"
        
        let queryWeight = HKSampleQuery(sampleType: weightType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            //returnnya itu HKSample, untuk specify ke "height, heart rate, and dietary energy consumed all use quantity samples." pakai HKQuantitySample
            
            if let result = results?.last as? HKQuantitySample {
                weight = "\(result.quantity)"
                Profile.profile.setWeight(weight: weight)
            }
        }
        
        
        let queryHeight = HKSampleQuery(sampleType: heightType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            //returnnya itu HKSample, untuk specify ke height, heart rate, and dietary energy consumed all use quantity samples. pakai HKQuantitySample
            
            if let result = results?.last as? HKQuantitySample {
                height = "\(result.quantity)"
                Profile.profile.setHeight(height: height)
            }
        }
        
        healthStore.execute(queryWeight)
        healthStore.execute(queryHeight)
        
        Profile.profile.setData(dateOfBirth: readData().0, sex: readData().1)
        ProfileCodable.saveProfile()
        UserDefaults.standard.setValue(true, forKey: "healthSyncswitch")
    }
}
