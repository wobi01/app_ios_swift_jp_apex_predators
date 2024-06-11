//
//  Predators.swift
//  JP Apex Predators
//
//  Created by Wobi on 28/05/2024.
//

import Foundation

class Predators: ObservableObject{
    @Published var allApexPredators: [ApexPredator] = []
    @Published var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator]{
        if searchTerm.isEmpty{
            return apexPredators
        }else{
            return apexPredators.filter{
                predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool){
        apexPredators.sort { predator1, predator2 in
            if alphabetical{
                predator1.name < predator2.name
            } else{
                predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type: PredatorType, and movie: PredatorMovies) -> [ApexPredator]{
        var filteredPredators = allApexPredators
        
        if type != .all {
                    filteredPredators = filteredPredators.filter { predator in
                        predator.type == type
                    }
                }
                
                if movie != .all {
                    filteredPredators = filteredPredators.filter { predator in
                        predator.movies.contains { $0.title == movie.name }
                    }
                }
                
                return filteredPredators
    }
    
    func delete(at offsets: IndexSet, in filteredDinos: [ApexPredator]){
        for offset in offsets{
            let predator = filteredDinos[offset]
            if let index = allApexPredators.firstIndex(where: { $0.id == predator.id}){
                allApexPredators.remove(at: index)
            }
        }
        apexPredators = filter(by: .all, and: .all)
    }
}
