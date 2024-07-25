//
//  FlightSearchScreen.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI

struct FlightSearchScreen: View {
    @State private var fromCity = ""
    @State private var destinationCity = ""
    @State private var departureDate = Date()
    @State private var returnDate = Date()
    @State private var passengers = 1
    @State private var flightClass = "Economy"
    
    @State private var minReturnDate = Date()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigate = false
    @State private var fromSuggestions: [String] = []
    @State private var destinationSuggestions: [String] = []

    let airports = [
        "JFK - John F. Kennedy International Airport",
        "LAX - Los Angeles International Airport",
        "ORD - O'Hare International Airport",
        "ATL - Hartsfield-Jackson Atlanta International Airport",
        "DFW - Dallas/Fort Worth International Airport",
        "DEN - Denver International Airport",
        "SFO - San Francisco International Airport",
        "LAS - McCarran International Airport",
        "SEA - Seattle-Tacoma International Airport",
        "MCO - Orlando International Airport"
    ]

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Trip Details")) {
                    AutocompleteTextField(placeholder: "From", text: $fromCity, suggestions: $fromSuggestions, allSuggestions: airports)
                    AutocompleteTextField(placeholder: "Destination", text: $destinationCity, suggestions: $destinationSuggestions, allSuggestions: airports)
                    DatePicker("Departure Date", selection: $departureDate, displayedComponents: .date)
                    DatePicker("Return Date", selection: $returnDate, in: minReturnDate..., displayedComponents: .date)
                        .onChange(of: departureDate, perform: { _ in
                            calculateMinReturnDate()
                        })
                    Stepper(value: $passengers, in: 1...10) {
                        Text("Passengers: \(passengers)")
                    }
                    Picker("Class", selection: $flightClass) {
                        Text("Economy").tag("Economy")
                        Text("Business").tag("Business")
                        Text("First Class").tag("First Class")
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Button(action: {
                validateAndProceed()
            }) {
                Text("Search Flights")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }

            NavigationLink(destination: FlightResultsScreen(
                fromCity: fromCity,
                destinationCity: destinationCity,
                departureDate: departureDate,
                returnDate: returnDate,
                passengers: passengers,
                flightClass: flightClass
            ), isActive: $navigate) {
                EmptyView()
            }
        }
        .navigationBarTitle("Book Your Flight", displayMode: .inline)
        .onAppear {
            calculateMinReturnDate()
        }
    }
    
    private func calculateMinReturnDate() {
        minReturnDate = Calendar.current.date(byAdding: .day, value: 1, to: departureDate) ?? departureDate
    }
    
    private func validateAndProceed() {
        if fromCity.isEmpty || destinationCity.isEmpty {
            showAlert = true
            alertMessage = "Please enter both From and Destination."
            return
        }
        
        if fromCity == destinationCity {
            showAlert = true
            alertMessage = "From and Destination cannot be the same."
            return
        }
        
        navigate = true
    }
}

struct AutocompleteTextField: View {
    var placeholder: String
    @Binding var text: String
    @Binding var suggestions: [String]
    var allSuggestions: [String]

    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .onChange(of: text, perform: { value in
                    if value.isEmpty {
                        suggestions = []
                    } else {
                        suggestions = allSuggestions.filter { $0.lowercased().contains(value.lowercased()) }
                    }
                })
            
            if !suggestions.isEmpty {
                List(suggestions, id: \.self) { suggestion in
                    Text(suggestion)
                        .onTapGesture {
                            text = suggestion
                            suggestions = []
                        }
                }
                .frame(maxHeight: 200)
            }
        }
    }
}

struct FlightSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FlightSearchScreen()
    }
}
