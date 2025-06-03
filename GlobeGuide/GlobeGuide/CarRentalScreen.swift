//
//  CarRentalScreen.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI

struct Car: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let location: String
    let pricePerDay: Double
    let availableFromDate: Date
    let availableToDate: Date
}

extension Car {
    static func mockData() -> [Car] {
        var cars = [Car]()
        
        for _ in 0..<20 {
            let name = ["Toyota Camry", "Honda CR-V", "BMW X5", "Audi A4", "Ford Mustang"].randomElement() ?? "Unknown"
            let type = ["Compact", "SUV", "Luxury"].randomElement() ?? "Unknown"
            let location = ["New York", "Los Angeles", "Chicago", "Miami", "San Francisco"].randomElement() ?? "Unknown"
            let pricePerDay = Double.random(in: 50...300)
            let availableFromDate = Date().addingTimeInterval(Double.random(in: -30...0) * 24 * 3600)
            let availableToDate = Date().addingTimeInterval(Double.random(in: 1...30) * 24 * 3600)
            
            let car = Car(name: name, type: type, location: location, pricePerDay: pricePerDay, availableFromDate: availableFromDate, availableToDate: availableToDate)
            cars.append(car)
        }
        
        return cars
    }
}

struct CarRentalScreen: View {
    @EnvironmentObject var itinerary: Itinerary
    @State private var selectedCarIndex = 0
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var cars: [Car] = []

    let carOptions = ["Compact", "SUV", "Luxury"]

    var filteredCars: [Car] {
        if selectedCarIndex == 0 {
            return cars.filter { $0.type == "Compact" }
        } else if selectedCarIndex == 1 {
            return cars.filter { $0.type == "SUV" }
        } else {
            return cars.filter { $0.type == "Luxury" }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Picker(selection: $selectedCarIndex, label: Text("Select Car Type")) {
                    ForEach(0 ..< carOptions.count) {
                        Text(self.carOptions[$0]).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Dates")
                        .font(.title3)
                        .bold()
                    
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                        .datePickerStyle(DefaultDatePickerStyle())
                        .padding(.horizontal)
                    
                    DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                        .datePickerStyle(DefaultDatePickerStyle())
                        .padding(.horizontal)
                }
                
                Button(action: {
                    self.cars = Car.mockData()
                }) {
                    Text("Search for Cars")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                // List of Results
                if !filteredCars.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Results:")
                            .font(.title3)
                            .bold()
                            .padding(.top, 20)
                            .padding(.horizontal)
                        
                        ForEach(filteredCars) { car in
                            CarResultView(car: car)
                                .environmentObject(itinerary) 
                        }
                    }
                    .padding(.vertical)
                } else {
                    Text("No cars found for \(carOptions[selectedCarIndex]) type.")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationBarTitle("Car Rental")
    }
}

struct CarResultView: View {
    let car: Car
    
    @EnvironmentObject var itinerary: Itinerary
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(car.name)
                    .font(.headline)
                Text(car.type)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(car.location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(String(format: "$%.2f / day", car.pricePerDay))
                .bold()
            Button(action: {
                itinerary.bookedCars.append(car)
                showAlert = true
                print("Booked car: \(car.name), \(car.type), \(car.location)")
            }) {
                Text("Book")
                    .bold()
                    .frame(width: 80, height: 30)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Booking Successful"), message: Text("You have successfully booked \(car.name)"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct CarRentalScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CarRentalScreen()
                .environmentObject(Itinerary())
        }
    }
}
