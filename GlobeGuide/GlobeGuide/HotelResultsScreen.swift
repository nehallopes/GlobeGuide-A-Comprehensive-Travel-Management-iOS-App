//
//  HotelResultsScreen.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI

struct Hotel: Identifiable, Codable {
    let id = UUID()
    let name: String
    let location: String
    let cost: Int
}

struct HotelResultsScreen: View {
    var destination: String
    var checkInDate: Date
    var checkOutDate: Date
    var guests: Int
    var roomType: String
    
    @State private var hotels: [Hotel] = []

    var body: some View {
        VStack {
            List(hotels) { hotel in
                HotelResultCell(hotel: hotel)
            }
        }
        .onAppear {
            generateHotels()
        }
        .navigationBarTitle("Hotel Results", displayMode: .inline)
    }

    private func generateHotels() {
        let hotelNames = ["Radison Blue", "Siam Hotel", "Grand Hyatt", "The Peninsula", "Mandarin Oriental"]
        for _ in 0..<10 {
            let name = hotelNames.randomElement()!
            let cost = Int.random(in: 100...500)
            
            let hotel = Hotel(name: name, location: destination, cost: cost)
            hotels.append(hotel)
        }
    }
}

struct HotelResultCell: View {
    var hotel: Hotel
    @EnvironmentObject var itinerary: Itinerary
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(hotel.name)
                    .font(.headline)
                Text(hotel.location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("$\(hotel.cost)")
                .bold()
            Button(action: {
                itinerary.bookedHotels.append(hotel)
                showAlert = true
                print("Booked hotel: \(hotel.name), \(hotel.location)")
            }) {
                Text("Book")
                    .bold()
                    .frame(width: 80, height: 30)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Booking Successful"), message: Text("You have successfully booked \(hotel.name)"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}

struct HotelResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HotelResultsScreen(destination: "", checkInDate: Date(), checkOutDate: Date(), guests: 1, roomType: "Standard")
                .environmentObject(Itinerary())
        }
    }
}
