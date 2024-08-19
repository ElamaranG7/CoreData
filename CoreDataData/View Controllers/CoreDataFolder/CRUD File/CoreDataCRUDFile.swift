//
//  CoreDataCRUDFile.swift
//  CoreDataData
//
//  Created by SAIL on 03/08/24.
//

import UIKit
import CoreData


class CoreDataCRUDFile{
    
    static let Shared = CoreDataCRUDFile()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    func createCoreData(name: String,emailID: String, id: Int, createdAt: Date, handler: @escaping (_ results: Bool?) -> Void) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            handler(false)
            return
        }
        
        let fetchUser: NSFetchRequest<Person> = Person.fetchRequest()
        fetchUser.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchUser)
            
            if results.isEmpty {
                let newPerson = Person(context: context)
                newPerson.name = name
                newPerson.emailId = emailID
                newPerson.id = Int64(id)
                newPerson.createdAt = createdAt
                
                try context.save()
                handler(true)
            } else {
                for item in results {
                    if item.id == Int32(id) {
                        context.delete(item)
                        print("Duplicate deleted")
                    }
                }
                let newPerson = Person(context: context)
                newPerson.name = name
                newPerson.emailId = emailID
                newPerson.id = Int64(id)
                newPerson.createdAt = createdAt
                
                try context.save()
                handler(true)
            }
        } catch {
            print("Failed to fetch or save data: \(error.localizedDescription)")
            handler(false)
        }
    }

    
    func readData( handler : @escaping (_ Products : [Person]?) -> Void ) {
        do {
            let data =  try context!.fetch(Person.fetchRequest())
            handler(data)
        }
        catch {
            print(error.localizedDescription)
            
        }
    }
    
    func updateData(id: Int,newEmailId: String, newName: String, handler: @escaping (_ result: Bool?) -> Void) {
            let fetchUser: NSFetchRequest<Person> = Person.fetchRequest()
            fetchUser.predicate = NSPredicate(format: "id = %d", id)
            
            do {
                let results = try context!.fetch(fetchUser)
                if let personToUpdate = results.first {
                    personToUpdate.name = newName
                    personToUpdate.emailId = newEmailId
                    try context!.save()
                    handler(true)
                } else {
                    print("No person found with the given id")
                    handler(false)
                }
            } catch {
                print(error.localizedDescription)
                handler(false)
            }
        }
   
    func DeleteData(_ data: Person,handler :@escaping (_ results :Bool?)-> Void){
        context?.delete(data)
        do {
            try context?.save()
            handler(true)
        }
        catch {
            print(error.localizedDescription)
            handler(false)
        }
    }
    
    
}



