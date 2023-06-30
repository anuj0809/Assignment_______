//
//  FacilityListView.swift
//  MVVM-SwiftUI-RadiusAssignment
//
//  Created by Rashmi Aher on 28/06/23.
//

import SwiftUI

struct FacilityListView: View {
    @ObservedObject var viewModel: FacilityViewModel
    
    var body: some View {
        List(viewModel.facilities) { facility in
            FacilityRowView(facility: facility, viewModel: viewModel)
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct FacilityListView_Previews: PreviewProvider {
    static var previews: some View {
        let facility1 = Facility(facilityId: "1", name: "Property Type", options: [
            Option(id: "1", name: "Apartment", icon: "apartment"),
            Option(id: "2", name: "Condo", icon: "condo"),
            Option(id: "3", name: "Boat House", icon: "boat"),
            Option(id: "4", name: "Land", icon: "land")
        ])
        
        let facility2 = Facility(facilityId: "2", name: "Number of Rooms", options: [
            Option(id: "5", name: "1 to 3 Rooms", icon: "rooms"),
            Option(id: "6", name: "No Rooms", icon: "no-room")
        ])
        
        let facility3 = Facility(facilityId: "3", name: "Other facilities", options: [
            Option(id: "7", name: "Swimming Pool", icon: "swimming"),
            Option(id: "8", name: "Garden Area", icon: "garden"),
            Option(id: "9", name: "Garage", icon: "garage")
        ])
        
        let viewModel = FacilityViewModel(facilities: [], exclusions: [])
        viewModel.facilities = [facility1, facility2, facility3]
        
        return FacilityListView(viewModel: viewModel)
    }
}

