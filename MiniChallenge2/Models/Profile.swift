//
//  Profile.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 14/06/21.
//

import Foundation

class Profile {
    public static var profile = Profile()
    
    private var dateOfBirth : String = "Not Retrived"
    private var sex: String = "Not Retrived"
    private var weight: String = "Not Retrived"
    private var height: String = "Not Retrived"
    
    static func getEmptyData() -> Profile{
        return profile
    }
    
    func setData(dateOfBirth: String, sex: String, weight: String, height: String){
        self.dateOfBirth = dateOfBirth
        self.sex = sex
        self.weight = weight
        self.height = height
    }
    
    static func returnProfileSection() -> [String]{
        let section = ["Date of Birth", "Sex", "Weight", "Height"]
        return section
    }
    
    func returnProfileData() -> [String]{
        let data = [self.dateOfBirth, self.sex, self.weight, self.height]
        return data
    }
    
    func returnProfileEmpty() -> [String]{
        let data = ["Not Retrived", "Not Retrived", "Not Retrived", "Not Retrived"]
        return data
    }
}
