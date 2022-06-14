//
//  CoreDataManager.swift
//  HelloCoreData
//
//  Created by faruk sirket on 7.01.2022.
//

import Foundation
import CoreData

class CoreDataManger {
    let persistentContainer: NSPersistentContainer
    init(){
        persistentContainer = NSPersistentContainer(name: "HelloCoreDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    func saveMovie(title: String) {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.title = title
        
        do{
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save movie \(error)")
        }
    }
    
    func getAllMovies() -> [Movie]{
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    func deleteMovie(movie: Movie){
        persistentContainer.viewContext.delete(movie)
        
        do{
            try persistentContainer.viewContext.save()
        }catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    func updateMovie() {
        do{
            try persistentContainer.viewContext.save()
        }catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
}
