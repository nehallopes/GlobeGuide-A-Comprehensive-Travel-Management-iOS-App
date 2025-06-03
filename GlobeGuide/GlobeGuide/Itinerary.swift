//
//  Itinerary.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI
import Combine

class Itinerary: ObservableObject {
    @Published var bookedCars: [Car] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var bookedHotels: [Hotel] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var bookedFlights: [Flight] {
        didSet {
            saveToUserDefaults()
        }
    }

    init() {
        self.bookedCars = Self.loadFromUserDefaults(forKey: "bookedCars") ?? []
        self.bookedHotels = Self.loadFromUserDefaults(forKey: "bookedHotels") ?? []
        self.bookedFlights = Self.loadFromUserDefaults(forKey: "bookedFlights") ?? []
        print("Loaded from UserDefaults: Cars - \(bookedCars.map { $0.name }), Hotels - \(bookedHotels.map { $0.name }), Flights - \(bookedFlights.map { $0.airline })")
    }

    private func saveToUserDefaults() {
        if let encodedCars = try? JSONEncoder().encode(bookedCars) {
            UserDefaults.standard.set(encodedCars, forKey: "bookedCars")
            print("Saved Cars to UserDefaults: \(bookedCars.map { $0.name })")
        }
        if let encodedHotels = try? JSONEncoder().encode(bookedHotels) {
            UserDefaults.standard.set(encodedHotels, forKey: "bookedHotels")
            print("Saved Hotels to UserDefaults: \(bookedHotels.map { $0.name })")
        }
        if let encodedFlights = try? JSONEncoder().encode(bookedFlights) {
            UserDefaults.standard.set(encodedFlights, forKey: "bookedFlights")
            print("Saved Flights to UserDefaults: \(bookedFlights.map { $0.airline })")
        }
    }

    private static func loadFromUserDefaults<T: Codable>(forKey key: String) -> [T]? {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([T].self, from: data) {
            return decoded
        }
        return nil
    }
}
