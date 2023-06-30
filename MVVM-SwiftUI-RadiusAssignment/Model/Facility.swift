//
//  Facility.swift
//  MVVM-RadiusAssignment
//
//  Created by Rashmi Aher on 28/06/23.
//

import Foundation

struct Facility: Codable, Identifiable {
    let facilityId: String
    let name: String
    let options: [Option]
    
    var id: String { facilityId }
    
    private enum CodingKeys: String, CodingKey {
        case facilityId = "facility_id"
        case name
        case options
    }
}

struct Option: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let icon: String
    
    static func == (lhs: Option, rhs: Option) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Exclusion: Codable {
    let facility_id: String
    let options_id: String
}


struct APIResponse: Codable {
    let facilities: [Facility]
    let exclusions: [[Exclusion]]
}

struct ModelData {
    var facilities: [Facility] = []
    var exclusions: [[Exclusion]] = []
}
