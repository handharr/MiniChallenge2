//
//  ProfileCodable.swift
//  MiniChallenge2
//
//  Created by Jackie Leonardy on 19/06/21.
//

import Foundation

class ProfileCodable{
    static func saveProfile(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Profile.profile) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedPerson")
        }
    }
    
    static func getProfile() -> Profile{
        if let savedPerson = UserDefaults.standard.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(Profile.self, from: savedPerson) {
                return loadedPerson
            }
        }
        return Profile.profile
    }
}
