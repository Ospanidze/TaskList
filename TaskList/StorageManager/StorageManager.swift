//
//  StorageManager.swift
//  TaskList
//
//  Created by Айдар Оспанов on 05.04.2023.
//

import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    private var viewContext: NSManagedObjectContext
    
    // MARK: Core Data stack

    private var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchData(completion: @escaping (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        
        do {
            let task = try viewContext.fetch(fetchRequest)
            completion(.success(task))
        } catch {
            completion(.failure(error))
        }
    }
    
    func save(_ taskName: String, completion: @escaping (Task) -> Void) {
        guard let nsEntityDescription = NSEntityDescription.entity(forEntityName: "Task", in: viewContext) else { return }
        guard let task = NSManagedObject(entity: nsEntityDescription, insertInto: viewContext) as? Task else { return }
        task.title = taskName
        completion(task)
        saveContext()
    }
    
    func delete(task: Task) {
        viewContext.delete(task)
        saveContext()
    }
    
    func edit(task: Task, newTask: String) {
        task.title = newTask
        saveContext()
    }
}
