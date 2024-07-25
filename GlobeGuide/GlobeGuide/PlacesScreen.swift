//
//  PlacesScreen.swift
//  GlobeGuide
//
//  Created by CDMStudent on 6/8/24.
//

import SwiftUI
import Combine

struct Place: Identifiable {
    let id: UUID
    let name: String
    let imageName: String
    let location: String
    let category: PlaceCategory
    let description: String
    let notableAttractions: String
    let funFact: String

    init(id: UUID = UUID(), name: String, imageName: String, location: String, category: PlaceCategory, description: String, notableAttractions: String, funFact: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.location = location
        self.category = category
        self.description = description
        self.notableAttractions = notableAttractions
        self.funFact = funFact
    }
}

extension Place {
    static func mockData() -> [Place] {
        return [
            Place(name: "Baga Beach", imageName: "", location: "Goa", category: .beaches, description: "A popular beach known for its nightlife and water sports.", notableAttractions: "Nightclubs, Water Sports", funFact: "Baga Beach is named after the Baga Creek, which empties into the Arabian Sea at the northern end of the beach."),
            Place(name: "Smokey Mountains", imageName: "", location: "North Carolina", category: .mountains, description: "A mountain range known for its misty peaks and diverse wildlife.", notableAttractions: "Great Smoky Mountains National Park", funFact: "The Smokies are among the oldest mountains in the world, formed around 200-300 million years ago."),
            Place(name: "New York City", imageName: "", location: "New York", category: .cities, description: "The largest city in the USA, known for its iconic skyline and vibrant culture.", notableAttractions: "Statue of Liberty, Central Park, Times Square", funFact: "New York City was the capital of the United States from 1785 to 1790."),
            Place(name: "Yosemite", imageName: "", location: "California", category: .nature, description: "A famous national park known for its giant sequoias, stunning waterfalls, and towering cliffs.", notableAttractions: "Yosemite Falls, El Capitan, Half Dome", funFact: "Yosemite Valley was formed by glaciers about one million years ago."),
            Place(name: "Santa Monica Beach", imageName: "", location: "California", category: .beaches, description: "A popular beach destination known for its pier and beautiful sunsets.", notableAttractions: "Santa Monica Pier, Pacific Park", funFact: "The Santa Monica Pier was built in 1909 and is home to the world's first solar-powered Ferris wheel."),
            Place(name: "Rocky Mountains", imageName: "", location: "Colorado", category: .mountains, description: "A major mountain range stretching from Canada to New Mexico.", notableAttractions: "Rocky Mountain National Park, Pikes Peak", funFact: "The Rockies contain the highest peak in North America, Mount Elbert, which stands at 14,440 feet."),
            Place(name: "Los Angeles", imageName: "", location: "California", category: .cities, description: "The entertainment capital of the world, known for its film and television industry.", notableAttractions: "Hollywood, Disneyland, Getty Center", funFact: "Los Angeles is the only city in North America to have hosted the Summer Olympics twice (1932 and 1984)."),
            Place(name: "Grand Canyon", imageName: "", location: "Arizona", category: .nature, description: "A massive canyon carved by the Colorado River, known for its stunning views.", notableAttractions: "South Rim, North Rim, Grand Canyon Skywalk", funFact: "The Grand Canyon is 277 miles long, up to 18 miles wide, and over a mile deep."),
            Place(name: "Miami Beach", imageName: "", location: "Florida", category: .beaches, description: "A coastal resort city known for its beautiful beaches and Art Deco architecture.", notableAttractions: "South Beach, Ocean Drive, Art Deco Historic District", funFact: "Miami Beach's Art Deco District contains the largest collection of Art Deco architecture in the world."),
            Place(name: "Appalachian Mountains", imageName: "", location: "Eastern USA", category: .mountains, description: "A mountain range known for its scenic beauty and outdoor recreational opportunities.", notableAttractions: "Appalachian Trail, Great Smoky Mountains National Park", funFact: "The Appalachian Trail is approximately 2,200 miles long, making it one of the longest continuously marked footpaths in the world."),
            Place(name: "San Francisco", imageName: "", location: "California", category: .cities, description: "A vibrant city known for its hilly terrain, cable cars, and iconic Golden Gate Bridge.", notableAttractions: "Golden Gate Bridge, Alcatraz Island, Fisherman's Wharf", funFact: "The Golden Gate Bridge was the longest suspension bridge in the world when it was completed in 1937."),
            Place(name: "Yellowstone", imageName: "", location: "Wyoming", category: .nature, description: "The first national park in the world, known for its geothermal features and wildlife.", notableAttractions: "Old Faithful, Yellowstone Lake, Grand Prismatic Spring", funFact: "Yellowstone is home to more than half of the world's geysers."),
            Place(name: "Bondi Beach", imageName: "", location: "Australia", category: .beaches, description: "A popular beach near Sydney, known for its surf culture and beautiful views.", notableAttractions: "Bondi to Coogee Coastal Walk, Bondi Icebergs", funFact: "Bondi Beach was added to the Australian National Heritage List in 2008."),
            Place(name: "Andes Mountains", imageName: "", location: "South America", category: .mountains, description: "The longest continental mountain range in the world, stretching along the western coast of South America.", notableAttractions: "Machu Picchu, Aconcagua, Torres del Paine", funFact: "The Andes are over 4,300 miles long and have an average height of about 13,000 feet."),
            Place(name: "Tokyo", imageName: "", location: "Japan", category: .cities, description: "The capital city of Japan, known for its modernity, traditional temples, and bustling districts.", notableAttractions: "Tokyo Tower, Shibuya Crossing, Meiji Shrine", funFact: "Tokyo is the most populous metropolitan area in the world, with over 37 million residents."),
            Place(name: "Amazon Rainforest", imageName: "", location: "South America", category: .nature, description: "The largest tropical rainforest in the world, known for its biodiversity.", notableAttractions: "Amazon River, Manaus, Meeting of Waters", funFact: "The Amazon Rainforest produces 20% of the world's oxygen."),
            Place(name: "Waikiki Beach", imageName: "", location: "Hawaii", category: .beaches, description: "A famous beach in Honolulu, known for its high-rise hotels and surfing spots.", notableAttractions: "Diamond Head, Honolulu Zoo, Waikiki Aquarium", funFact: "Waikiki means 'spouting waters' in Hawaiian."),
            Place(name: "Himalayas", imageName: "", location: "Asia", category: .mountains, description: "The highest mountain range in the world, home to Mount Everest.", notableAttractions: "Mount Everest, Annapurna, Ladakh", funFact: "The Himalayas are still rising by an average of 1 cm per year due to the collision of the Indian Plate and Eurasian Plate."),
            Place(name: "Paris", imageName: "", location: "France", category: .cities, description: "The capital city of France, known for its art, fashion, and landmarks like the Eiffel Tower.", notableAttractions: "Eiffel Tower, Louvre Museum, Notre-Dame Cathedral", funFact: "Paris is often called 'The City of Light' because it was one of the first cities to have street lighting."),
            Place(name: "Sahara Desert", imageName: "", location: "Africa", category: .nature, description: "The largest hot desert in the world, covering much of North Africa.", notableAttractions: "Erg Chebbi, Siwa Oasis, Tibesti Mountains", funFact: "The Sahara Desert is roughly the size of the United States.")
        ]
    }
}

enum PlaceCategory: String, CaseIterable {
    case all = "All"
    case beaches = "Beaches"
    case mountains = "Mountains"
    case cities = "Cities"
    case nature = "Nature"
}

struct PexelsResponse: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    let src: PhotoSource
}

struct PhotoSource: Codable {
    let medium: String
}

class NetworkManager: ObservableObject {
    func fetchImages(for query: String, completion: @escaping ([String]) -> Void) {
        let apiKey = "kw7OU3OULL3zZKqeT77zTPL93czINm3gpsv5r7kChz6TxN7Te6DBPfM6"
        let urlString = "https://api.pexels.com/v1/search?query=\(query)&per_page=20"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, error == nil {
                if let imageResponse = try? JSONDecoder().decode(PexelsResponse.self, from: data) {
                    let imageUrls = imageResponse.photos.map { $0.src.medium }
                    DispatchQueue.main.async {
                        completion(imageUrls)
                    }
                }
            }
        }.resume()
    }
}

class PlacesManager: ObservableObject {
    @Published var selectedCategory: PlaceCategory = .all
    @Published var places: [Place] = []

    private let networkManager = NetworkManager()

    init() {
        fetchPlaces(for: selectedCategory)
    }

    func fetchPlaces(for category: PlaceCategory) {
        let query = category == .all ? "landscape" : category.rawValue
        networkManager.fetchImages(for: query) { [weak self] imageUrls in
            let mockPlaces = Place.mockData().filter { place in
                category == .all || place.category == category
            }
            self?.places = zip(mockPlaces, imageUrls).map { mockPlace, imageUrl in
                Place(
                    id: mockPlace.id,
                    name: mockPlace.name,
                    imageName: imageUrl,
                    location: mockPlace.location,
                    category: mockPlace.category,
                    description: mockPlace.description,
                    notableAttractions: mockPlace.notableAttractions,
                    funFact: mockPlace.funFact
                )
            }
        }
    }

}

struct PlaceCard: View {
    let place: Place
    let cardWidth: CGFloat = 150
    let cardHeight: CGFloat = 200

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: place.imageName)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: 120)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
                    .frame(width: cardWidth, height: 120)
            }
            Text(place.name)
                .font(.headline)
                .foregroundColor(.primary)
            Text(place.location)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(width: cardWidth, height: cardHeight)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct CategoryTag: View {
    let category: PlaceCategory
    let isSelected: Bool
    
    var body: some View {
        Text(category.rawValue)
            .frame(minWidth: 100)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(20)
            .lineLimit(1)
    }
}

struct PlacesScreen: View {
    @StateObject var placesManager = PlacesManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(PlaceCategory.allCases, id: \.self) { category in
                        CategoryTag(category: category, isSelected: placesManager.selectedCategory == category)
                            .onTapGesture {
                                placesManager.selectedCategory = category
                                placesManager.fetchPlaces(for: category)
                            }
                    }
                }
                .padding(.horizontal)
            }
            
            ScrollView {
                if placesManager.places.isEmpty {
                    ProgressView()
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(placesManager.places, id: \.id) { place in
                            NavigationLink(destination: PlaceDetailView(place: place)) {
                                PlaceCard(place: place)
                            }
                        }
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color("AccentColor"))
        .navigationBarTitle("Places To Visit", displayMode: .inline)
    }
}

struct PlacesScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlacesScreen()
        }
    }
}
