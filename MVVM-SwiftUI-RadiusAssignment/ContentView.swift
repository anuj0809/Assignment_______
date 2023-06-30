//
//  ContentView.swift
//  MVVM-SwiftUI-RadiusAssignment
//
//  Created by Rashmi Aher on 28/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FacilityViewModel(facilities: [], exclusions: [])
    
    var body: some View {
        FacilityListView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
