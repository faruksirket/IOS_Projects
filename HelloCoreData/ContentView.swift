//
//  ContentView.swift
//  HelloCoreData
//
//  Created by faruk sirket on 7.01.2022.
//

import SwiftUI

struct ContentView: View {
    let coreDM: CoreDataManger
    @State private var movieTitle: String = ""
    @State private var movies: [Movie] = [Movie]()
    @State private var needsRefresh: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter title", text: $movieTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save"){
                    coreDM.saveMovie(title: movieTitle)
                    populateMovies()
                }
                List{
                    ForEach(movies, id: \.self){movie in
                        NavigationLink(
                            destination: MovieDetails(movie: movie, coreDM: coreDM, needsRefresh : $needsRefresh),
                        label: {
                            Text(movie.title ?? "")
                        })
                        
                    }.onDelete(perform: {indexSet in
                        indexSet.forEach{index in
                            let movie = movies[index]
                            //delete movie using core data manager
                            coreDM.deleteMovie(movie: movie)
                            populateMovies()
                        }
                    })
                }.listStyle(.plain)
                    .accentColor(needsRefresh ? .white : .black)
                Spacer()
            }.padding()
                .navigationTitle("Movies")
                .onAppear(perform: populateMovies)
        }
    }
    private func populateMovies(){
        movies = coreDM.getAllMovies()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManger())
    }
}
