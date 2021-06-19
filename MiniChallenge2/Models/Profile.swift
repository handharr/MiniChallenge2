//
//  Profile.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 14/06/21.
//

import Foundation

class Profile: Codable {
    public static var profile = Profile()
    
    private var dateOfBirth : String = "Not Retrived"
    private var sex: String = "Not Retrived"
    private var weight: String = "Not Retrived"
    private var height: String = "Not Retrived"
    
    static func getEmptyData() -> Profile{
        return profile
    }
    
    func setData(dateOfBirth: String, sex: String){
        self.dateOfBirth = dateOfBirth
        self.sex = sex
    }
    
    func setWeight(weight : String){
        self.weight = weight
    }
    
    func setHeight(height : String){
        self.height = height
    }
    
    static func returnProfileSection() -> [String]{
        let section = ["Date of Birth", "Sex", "Weight", "Height"]
        return section
    }
    
    func returnProfileData() -> [String]{
        let profile = ProfileCodable.getProfile()
        let data = [profile.dateOfBirth, profile.sex, profile.weight, profile.height]
        return data
    }
    
    func returnProfileEmpty() -> [String]{
        let data = ["Not Retrived", "Not Retrived", "Not Retrived", "Not Retrived"]
        return data
    }
}
