//
//  HotelSearchScreen.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI

struct HotelSearchScreen: View {
    @State private var destination = ""
    @State private var checkInDate = Date()
    @State private var checkOutDate = Date()
    @State private var guests = 1
    @State private var roomType = "Standard"
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigate = false
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Stay Details")) {
                    TextField("Destination", text: $destination)
                    DatePicker("Check-in Date", selection: $checkInDate, displayedComponents: .date)
                        .onChange(of: checkInDate) { newValue in
                            if checkOutDate <= newValue {
                                checkOutDate = Calendar.current.date(byAdding: .day, value: 1, to: newValue) ?? newValue
                            }
                        }
                    DatePicker("Check-out Date", selection: $checkOutDate, in: checkInDate..., displayedComponents: .date)
                    Stepper(value: $guests, in: 1...10) {
                        Text("Guests: \(guests)")
                    }
                    Picker("Room Type", selection: $roomType) {
                        Text("Standard").tag("Standard")
                        Text("Deluxe").tag("Deluxe")
                        Text("Suite").tag("Suite")
                    }
                }
            }
            Button(action: {
                if destination.isEmpty {
                    alertMessage = "Destination cannot be empty."
                    showAlert = true
                } else {
                    navigate = true
                }
            }) {
                Text("Search Hotels")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            NavigationLink(destination: HotelResultsScreen(
                destination: destination,
                checkInDate: checkInDate,
                checkOutDate: checkOutDate,
                guests: guests,
                roomType: roomType
            ), isActive: $navigate) {
                EmptyView()
            }
        }
        .navigationBarTitle("Book Your Hotel", displayMode: .inline)
    }
}

struct HotelSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HotelSearchScreen()
        }
    }
}
