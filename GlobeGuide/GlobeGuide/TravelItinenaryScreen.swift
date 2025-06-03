//
//  TravelItinenaryScreen.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI

struct TravelItineraryScreen: View {
    @EnvironmentObject var itinerary: Itinerary

    var body: some View {
        List {
            Section(header: Text("Booked Cars")) {
                if itinerary.bookedCars.isEmpty {
                    Text("No cars booked yet.")
                } else {
                    ForEach(itinerary.bookedCars) { car in
                        VStack(alignment: .leading) {
                            Text(car.name)
                                .font(.headline)
                            Text(car.type)
                                .font(.subheadline)
                            Text(car.location)
                                .font(.subheadline)
                            Text(String(format: "$%.2f / day", car.pricePerDay))
                                .bold()
                        }
                        .padding()
                    }
                    .onDelete(perform: deleteCarItems)
                }
            }
            
            Section(header: Text("Booked Hotels")) {
                if itinerary.bookedHotels.isEmpty {
                    Text("No hotels booked yet.")
                } else {
                    ForEach(itinerary.bookedHotels) { hotel in
                        VStack(alignment: .leading) {
                            Text(hotel.name)
                                .font(.headline)
                            Text(hotel.location)
                                .font(.subheadline)
                            Text("$\(hotel.cost)")
                                .bold()
                        }
                        .padding()
                    }
                    .onDelete(perform: deleteHotelItems)
                }
            }

            Section(header: Text("Booked Flights")) {
                if itinerary.bookedFlights.isEmpty {
                    Text("No flights booked yet.")
                } else {
                    ForEach(itinerary.bookedFlights) { flight in
                        VStack(alignment: .leading) {
                            Text("\(flight.airline) - \(flight.flightClass)")
                                .font(.headline)
                            Text("From: \(flight.fromCity) To: \(flight.destinationCity)")
                            Text("Departure: \(flight.departureDate, formatter: dateFormatter)")
                            Text("Arrival: \(flight.arrivalDate, formatter: dateFormatter)")
                            Text(String(format: "Price: $%.2f", flight.price))
                                .bold()
                        }
                        .padding()
                    }
                    .onDelete(perform: deleteFlightItems)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Travel Itinerary", displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
        .onAppear {
            print("Current itinerary - Cars: \(itinerary.bookedCars.map { $0.name }.joined(separator: ", ")), Hotels: \(itinerary.bookedHotels.map { $0.name }.joined(separator: ", ")), Flights: \(itinerary.bookedFlights.map { $0.airline }.joined(separator: ", "))")
        }
    }

    private func deleteCarItems(at offsets: IndexSet) {
        itinerary.bookedCars.remove(atOffsets: offsets)
        print("Deleted car items at offsets: \(offsets)")
    }

    private func deleteHotelItems(at offsets: IndexSet) {
        itinerary.bookedHotels.remove(atOffsets: offsets)
        print("Deleted hotel items at offsets: \(offsets)")
    }

    private func deleteFlightItems(at offsets: IndexSet) {
        itinerary.bookedFlights.remove(atOffsets: offsets)
        print("Deleted flight items at offsets: \(offsets)")
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

struct TravelItineraryScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TravelItineraryScreen()
                .environmentObject(Itinerary())
        }
    }
}
