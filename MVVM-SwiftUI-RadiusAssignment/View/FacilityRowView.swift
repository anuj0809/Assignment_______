//
//  FacilityRowView.swift
//  MVVM-SwiftUI-RadiusAssignment
//
//  Created by Rashmi Aher on 28/06/23.
//

import SwiftUI

struct FacilityRowView: View {
    var facility: Facility
    @State private var selectedOption: Option?
    @ObservedObject var viewModel: FacilityViewModel
    
    var exclusions: [Exclusion] {
        return viewModel.getExclusions(for: facility.facilityId)
    }
    
    var body: some View {
        VStack {
            Text(facility.name)
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(facility.options) { option in
                        Button(action: {
                            selectOption(option)
                        }) {
                            VStack {
                                Image(option.icon)
                                Text(option.name)
                            }
                            .padding()
                            .background(isOptionExcluded(option) ? Color.gray.opacity(0.2) : (selectedOption == option ? Color.blue.opacity(0.2) : Color.clear))
                            .cornerRadius(8)
                            .disabled(isOptionExcluded(option))
                        }
                    }
                }
            }
        }
    }
    
    private func selectOption(_ option: Option) {
        if isOptionExcluded(option) {
            // Option is excluded, handle accordingly (show alert, etc.)
            return
        }
        selectedOption = option
    }
    
    private func isOptionExcluded(_ option: Option) -> Bool {
        let excludedOptions = exclusions.compactMap { $0.options_id }
        return excludedOptions.contains(option.id)
    }
//    private func isOptionExcluded(_ option: Option) -> Bool {
//        guard let selectedFacility = viewModel.selectedFacility else {
//            return false
//        }
//
//        if selectedFacility.facilityid == "1" { // Check if selected facility is "Property Type"
//            let exclusions = viewModel.exclusions.flatMap { $0 }
//            let excludedOptions = exclusions.filter { exclusion in
//                return exclusion.facility_id == "1" && exclusion.options_id == option.id
//            }
//            return !excludedOptions.isEmpty
//        }
//
//        return false
//    }
}


struct FacilityRowView_Previews: PreviewProvider {
    static var previews: some View {
        let facility = Facility(facilityId: "1", name: "Property Type", options: [
            Option(id: "1", name: "Apartment", icon: "apartment"),
            Option(id: "2", name: "Condo", icon: "condo"),
            Option(id: "3", name: "Boat House", icon: "boat"),
            Option(id: "4", name: "Land", icon: "land")
        ])
        
        let viewModel = FacilityViewModel(facilities: [facility], exclusions: [])
        
        return FacilityRowView(facility: facility, viewModel: viewModel)
    }
}

