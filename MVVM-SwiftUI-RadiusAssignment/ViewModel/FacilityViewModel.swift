//
//  FacilityViewModel.swift
//  MVVM-RadiusAssignment
//
//  Created by Rashmi Aher on 28/06/23.
//

import Alamofire
import SwiftyJSON

class FacilityViewModel: ObservableObject {
    @Published var facilities: [Facility] = []
    private var modelData = ModelData()
    @Published var exclusions: [[Exclusion]]
    @Published var selectedFacility: Facility?
    
    init(facilities: [Facility], exclusions: [[Exclusion]]) {
        self.facilities = facilities
        self.exclusions = exclusions
    }
    
    func selectFacility(_ facility: Facility) {
        selectedFacility = facility
    }
    
    func fetchData() {
        guard let url = URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db") else {
            return
        }
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    
                    if let data = response.data {
                        do {
                            let json = try JSON(data: data)
                            
                            // Parse facilities
                            var facilities: [Facility] = []
                            if let facilitiesJSON = json["facilities"].array {
                                for facilityJSON in facilitiesJSON {
                                    let facilityId = facilityJSON["facility_id"].stringValue
                                    let name = facilityJSON["name"].stringValue
                                    
                                    // Parse options
                                    var options: [Option] = []
                                    if let optionsJSON = facilityJSON["options"].array {
                                        for optionJSON in optionsJSON {
                                            let optionId = optionJSON["id"].stringValue
                                            let optionName = optionJSON["name"].stringValue
                                            let optionIcon = optionJSON["icon"].stringValue
                                            
                                            let option = Option(id: optionId, name: optionName, icon: optionIcon)
                                            options.append(option)
                                        }
                                    }
                                    
                                    let facility = Facility(facilityId: facilityId, name: name, options: options)
                                    facilities.append(facility)
                                }
                            }
                            
                            // Parse exclusions
                            var exclusions: [[Exclusion]] = []
                            if let exclusionsJSON = json["exclusions"].array {
                                for exclusionGroupJSON in exclusionsJSON {
                                    var exclusionGroup: [Exclusion] = []
                                    if let exclusionsArrayJSON = exclusionGroupJSON.array {
                                        for exclusionJSON in exclusionsArrayJSON {
                                            let facilityId = exclusionJSON["facility_id"].stringValue
                                            let optionsId = exclusionJSON["options_id"].stringValue
                                            
                                            let exclusion = Exclusion(facility_id: facilityId, options_id: optionsId)
                                            exclusionGroup.append(exclusion)
                                        }
                                    }
                                    
                                    exclusions.append(exclusionGroup)
                                }
                            }
                            
                            DispatchQueue.main.async {
                                self.facilities = facilities
                                self.modelData.facilities = facilities
                                self.modelData.exclusions = exclusions
                            }
                        } catch {
                            print("Error parsing JSON: \(error)")
                        }
                    }
                    
                case .failure(let error):
                    print("Error fetching data: \(error)")
            }
        }
    }
    
    func getExclusions(for facilityID: String) -> [Exclusion] {
        return modelData.exclusions.first(where: { $0.first?.facilityID == facilityID }) ?? []
    }
    
//    func getExclusions(for facilityId: String) -> [Exclusion] {
//        return exclusions.flatMap { $0 }.filter { $0.facility_id == facilityId }
//    }
}

