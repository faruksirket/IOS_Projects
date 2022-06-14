//
//  MovieDetails.swift
//  HelloCoreData
//
//  Created by faruk sirket on 7.01.2022.
//

import SwiftUI

struct MovieDetails: View {
    let movie: Movie
    @State private var movieName: String = ""
    let coreDM: CoreDataManger
    @Binding var needsRefresh: Bool
    var body: some View {
        VStack{
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update"){
                if !movieName.isEmpty {
                    movie.title = movieName
                    coreDM.updateMovie()
                    needsRefresh.toggle()
                }
            }
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        
        let movie = Movie()
        
        MovieDetails(movie: movie, coreDM: CoreDataManger(), needsRefresh: .constant(false))
    }
}
