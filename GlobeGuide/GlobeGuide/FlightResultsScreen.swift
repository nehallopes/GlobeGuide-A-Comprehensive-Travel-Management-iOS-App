//
//  FlightResultsScreen.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI

struct Flight: Identifiable, Codable {
    let id = UUID()
    let airline: String
    let fromCity: String
    let destinationCity: String
    let departureDate: Date
    let arrivalDate: Date
    let price: Double
    let flightClass: String
}

struct FlightResultsScreen: View {
    var fromCity: String
    var destinationCity: String
    var departureDate: Date
    var returnDate: Date
    var passengers: Int
    var flightClass: String
    
    @State private var flights: [Flight] = []
    @State private var showAlert = false
    @EnvironmentObject var itinerary: Itinerary

    var body: some View {
        VStack {
            List(flights) { flight in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(flight.airline) - \(flight.flightClass)")
                            .font(.headline)
                        Text("From: \(flight.fromCity) To: \(flight.destinationCity)")
                        Text("Departure: \(flight.departureDate, formatter: dateFormatter)")
                        Text("Arrival: \(flight.arrivalDate, formatter: dateFormatter)")
                        Text(String(format: "Price: $%.2f", flight.price))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button(action: {
                        itinerary.bookedFlights.append(flight)
                        showAlert = true
                    }) {
                        Text("Book")
                            .bold()
                            .frame(width: 80, height: 30)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Booking Successful"), message: Text("You have successfully booked the flight"), dismissButton: .default(Text("OK")))
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .onAppear {
            generateFlights()
        }
        .navigationBarTitle("Flight Results", displayMode: .inline)
    }

    private func generateFlights() {
        let airlines = ["Airline A", "Airline B", "Airline C"]
        for _ in 0..<10 {
            let airline = airlines.randomElement()!
            let departure = departureDate.addingTimeInterval(TimeInterval.random(in: 3600...7200))
            let arrival = departure.addingTimeInterval(TimeInterval.random(in: 7200...14400))
            let price = Double.random(in: 200...800)
            
            let flight = Flight(
                airline: airline,
                fromCity: fromCity,
                destinationCity: destinationCity,
                departureDate: departure,
                arrivalDate: arrival,
                price: price,
                flightClass: flightClass
            )
            flights.append(flight)
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

struct FlightResultsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlightResultsScreen(fromCity: "New York", destinationCity: "Los Angeles", departureDate: Date(), returnDate: Date(), passengers: 1, flightClass: "Economy")
                .environmentObject(Itinerary())
        }
    }
}
