# Assignment

This iOS app allows users to select facilities and their options. The app fetches data from an API and displays a list of facilities along with their options. Users can select one option from each facility, taking into account exclusion conditions.

## Features

- Display a list of facilities and their options
- Select one option from each facility
- Handle exclusion conditions to prevent invalid combinations

## Architecture and Design Pattern

The app follows the MVVM (Model-View-ViewModel) design pattern, which separates the responsibilities of data management, UI, and business logic.

- Model: The `Facility` and `Option` structs represent the data models obtained from the API response.

- View: The `FacilityRowView` displays a single facility and its options in a row. It uses SwiftUI views and handles the rendering of the UI.

- ViewModel: The `FacilityViewModel` acts as a mediator between the View and the Model. It retrieves data from the API, manages the state of selected options, and provides exclusion logic.

## Third-Party Library

The app uses Alamofire for handling network requests. Alamofire simplifies the process of making API calls and handling responses.

## Files and Logic

- `FacilityRowView.swift`: Defines the SwiftUI view for displaying a facility and its options. It includes the UI logic and handles user interactions.

- `FacilityViewModel.swift`: Implements the ViewModel for the Facility selection. It manages the state, performs API requests, and handles the exclusion logic.

- `Model.swift`: Contains the data models (`Facility` and `Option`) used to represent the API response.

## Usage

To use the app, open the project in Xcode, build and run it on a simulator or a physical device. The app will fetch data from the API and display the list of facilities with selectable options. Users can choose one option from each facility, and the app will enforce exclusion conditions to prevent invalid selections.
