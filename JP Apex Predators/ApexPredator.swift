//
//  ApexPredator.swift
//  JP Apex Predators
//
//  Created by Wobi on 28/05/2024.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable{
    
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [Movies]
    let movieScenes: [MovieScenes]
    let link: String
    
    var image: String{
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct Movies: Decodable, Identifiable{
        let id: Int
        let title: String
        
        enum CodingKeys: String, CodingKey{
            case title
        }
        
        init(from decoder: Decoder) throws{
            let container = try decoder.singleValueContainer()
            self.title = try container.decode(String.self)
            self.id = title.hashValue
        }
    }
    
    struct MovieScenes: Decodable, Identifiable{
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    
}


enum PredatorType: String, Decodable, CaseIterable, Identifiable{
    case all
    case land
    case air
    case sea
    
    var id: PredatorType{
        self
    }
    
    var background: Color{
        switch self {
        case .land:
            .brown
        case .air:
            .teal
        case .sea:
            .blue
        case .all:
            .black
        }
    }
    
    var icon: String{
        switch self{
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}

enum PredatorMovies: String, Decodable, CaseIterable, Identifiable{
    case all = "All"
    case jurassicPark = "Jurassic Park"
    case lostWorld = "The Lost World: Jurassic Park"
    case jurassicPark3 = "Jurassic Park III"
    case jurassicWorld = "Jurassic World"
    case jurassicWorldFallenKingdom = "Jurassic World: Fallen Kingdom"
    case jurassicWorldDominion = "Jurassic World: Dominion"
    
    var id: PredatorMovies{
        self
    }
    
    var name: String{
        rawValue
    }
    
    var icon: String{
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .jurassicPark:
            "1.square"
        case .lostWorld:
            "2.square"
        case .jurassicPark3:
            "3.square"
        case .jurassicWorld:
            "4.square"
        case .jurassicWorldFallenKingdom:
            "5.square"
        case .jurassicWorldDominion:
            "6.square"
        }
    }
}
