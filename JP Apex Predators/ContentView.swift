//
//  ContentView.swift
//  JP Apex Predators
//
//  Created by Wobi on 28/05/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = PredatorType.all
    @State var movieSelection = PredatorMovies.all
    
    var filteredDinos: [ApexPredator]{
        var filteredPredators = predators.filter(by: currentSelection, and: movieSelection)
        if alphabetical{
            filteredPredators.sort {
                $0.name < $1.name
            }
        }
        return searchText.isEmpty ? filteredPredators : filteredPredators.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(filteredDinos) { predator in
                    NavigationLink{
                        PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                    } label: {
                        HStack{
                            //Dinosaur image
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .shadow(color: .white, radius: 1)
                            
                            VStack(alignment: .leading){
                                //Name
                                Text(predator.name)
                                    .fontWeight(.bold)
                                
                                
                                //Type
                                Text(predator.type.rawValue.capitalized)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 13)
                                    .padding(.vertical, 5)
                                    .background(predator.type.background)
                                    .clipShape(.capsule)
                            }
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        withAnimation{
                            alphabetical.toggle()
                        }
                    }label: {
//                        if alphabetical{
//                            Image(systemName: "film")
//                        }else{
//                            Image(systemName: "textformat")
//                        }
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                ToolbarItem(){
                    Button{
                        withAnimation{
                            searchText = ""
                            currentSelection = PredatorType.all
                            movieSelection = PredatorMovies.all
                        }
                    }label:{
                        Text("Reset filters")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    //dino type filter
                    Menu{
                        Picker("Filter", selection: $currentSelection.animation()){
                            ForEach(PredatorType.allCases){ type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                        //dino movie apperance filter
                        Menu{
                            Picker("Filter", selection: $movieSelection.animation()){
                                ForEach(PredatorMovies.allCases){ type in
                                    Label(type.name, systemImage: type.icon)
                                }
                            }
                        } label: {
                            Text("Filter by movie")
                            Image(systemName: "film")
                        }
                        Button(action: {withAnimation{
                            predators.decodeApexPredatorData()
                        }
                        })
                        {
                                Label("Restore deleted dinos", systemImage: "restart.circle")
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    func delete(at offsets: IndexSet){
        predators.delete(at: offsets, in: filteredDinos)
    }
    
}

#Preview {
    ContentView()
}
