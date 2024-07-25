//
//  MapsScreen.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI
import MapKit

struct MapsScreen: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var searchQuery: String = ""
    @State private var showSearchResults: Bool = false
    @State private var places: [MKMapItem] = []
    @State private var selectedPlace: MKMapItem?
    @State private var showingDirections: Bool = false
    @State private var route: MKRoute?

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    MapView(region: viewModel.binding, places: $places, selectedPlace: $selectedPlace, route: $route)
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            viewModel.checkIfLocationIsEnabled()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                VStack {
                    Spacer()

                    if showSearchResults {
                        List(places, id: \.self) { place in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(place.name ?? "")
                                        .font(.headline)
                                    Text(place.placemark.title ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedPlace = place
                                showSearchResults = false
                                showSelectedPlace()
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()
                        .frame(height: 300)
                    }

                    SearchBar(text: $searchQuery, onSearch: performSearch)
                        .padding(.horizontal)

                    if let selectedPlace = selectedPlace {
                        VStack {
                            Text(selectedPlace.name ?? "Selected Place")
                                .font(.headline)
                                .padding(.top)
                            Text(selectedPlace.placemark.title ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.bottom)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                    }

                    Button(action: {
                        if let selectedPlace = selectedPlace {
                            showRoute(to: selectedPlace)
                        }
                    }) {
                        Text("Get Directions")
                            .foregroundColor(.white)
                            .padding()
                            .background(selectedPlace != nil ? Color.blue : Color.gray)
                            .cornerRadius(10)
                    }
                    .padding()
                    .disabled(selectedPlace == nil)
                    .sheet(isPresented: $showingDirections) {
                        if let route = route {
                            DirectionsView(route: route)
                        }
                    }
                }
                .padding(.bottom)
            }
            .onDisappear {
                showingDirections = false
            }
            .navigationBarTitle("Maps", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: viewModel.centerOnUserLocation) {
                Image(systemName: "location.fill")
                    .foregroundColor(.red)
            })
        }
    }

    private func performSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery
        request.region = viewModel.mapRegion

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("Search error: \(error.localizedDescription)")
                return
            }
            guard let response = response else { return }
            places = response.mapItems
            showSearchResults = true
        }
    }

    private func showSelectedPlace() {
        guard let selectedPlace = selectedPlace else { return }
        let placemark = selectedPlace.placemark
        viewModel.mapRegion = MKCoordinateRegion(center: placemark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }

    private func showRoute(to destination: MKMapItem) {
        guard let userLocation = viewModel.locationManager?.location else { return }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
        request.destination = destination
        request.requestsAlternateRoutes = false
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Directions error: \(error.localizedDescription)")
                return
            }
            guard let unwrappedResponse = response else { return }

            route = unwrappedResponse.routes.first
            if let route = route {
                viewModel.mapRegion = MKCoordinateRegion(route.polyline.boundingMapRect)
                showingDirections = true
            }
        }
    }
}

struct MapsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapsScreen()
    }
}
