//
//  PlaceDetailView.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI

struct PlaceDetailView: View {
    let place: Place
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: place.imageName)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .frame(height: 120)
                }
                
                Text(place.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Text(place.location)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("Description")
                    .font(.headline)
                    .padding(.top)
                Text(place.description)
                    .padding(.bottom)
                
                Text("Notable Attractions")
                    .font(.headline)
                    .padding(.top)
                Text(place.notableAttractions)
                    .padding(.bottom)
                
                Text("Fun Fact")
                    .font(.headline)
                    .padding(.top)
                Text(place.funFact)
                    .padding(.bottom)
            }
            .padding()
        }
        .navigationTitle(place.name)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(place: Place.mockData().first!)
    }
}
