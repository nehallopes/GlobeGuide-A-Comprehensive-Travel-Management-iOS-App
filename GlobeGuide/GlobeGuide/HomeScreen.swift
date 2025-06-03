//
//  HomeScreen.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var itinerary = Itinerary()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                    
                    Text("Hello! Nehal,")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    Text("Come let's explore with GlobeGuide")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        NavigationLink(destination: FlightSearchScreen().environmentObject(itinerary)) {
                            CategoryView(imageName: "airplane", title: "Flight Booking")
                        }
                        NavigationLink(destination: HotelSearchScreen().environmentObject(itinerary)) {
                            CategoryView(imageName: "building.2", title: "Hotel Booking")
                        }
                        NavigationLink(destination: CarRentalScreen().environmentObject(itinerary)) {
                            CategoryView(imageName: "car", title: "Car Rental")
                        }
                        NavigationLink(destination: MapsScreen()) {
                            CategoryView(imageName: "globe", title: "Map")
                        }
                        NavigationLink(destination: PlacesScreen()) {
                            CategoryView(imageName: "mappin.and.ellipse", title: "Places")
                        }
                        NavigationLink(destination: TravelItineraryScreen().environmentObject(itinerary)) {
                            CategoryView(imageName: "doc.text", title: "Itinerary")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    HStack {
                        Text("Popular Places")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            DestinationView(imageName: "smokey_mountains", title: "Smokey Mountains", location: "North Carolina")
                            DestinationView(imageName: "baga_beach_goa", title: "Baga Beach", location: "Goa")
                            DestinationView(imageName: "eiffel_tower_paris", title: "Eiffel Tower", location: "Paris")
                            DestinationView(imageName: "grand_canyon", title: "Grand Canyon", location: "Arizona")
                            DestinationView(imageName: "sydney_opera_house", title: "Sydney Opera House", location: "Sydney")
                            DestinationView(imageName: "tokyo_tower", title: "Tokyo Tower", location: "Tokyo")
                            DestinationView(imageName: "machu_picchu", title: "Machu Picchu", location: "Peru")
                            DestinationView(imageName: "colosseum_rome", title: "Colosseum", location: "Rome")
                            DestinationView(imageName: "niagara_falls", title: "Niagara Falls", location: "New York")
                            DestinationView(imageName: "table_mountain", title: "Table Mountain", location: "Cape Town")
                        }
                        .padding(.horizontal)
                    }

                }
            }
            .navigationBarHidden(true)
        }
        .environmentObject(itinerary)
    }
}

struct CategoryView: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            Text(title)
                .font(.footnote)
                .foregroundColor(.black)
        }
    }
}

struct DestinationView: View {
    var imageName: String
    var title: String
    var location: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 200)
                .cornerRadius(10)
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            Text(location)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
