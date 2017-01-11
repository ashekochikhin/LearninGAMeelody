//
//  DataBase.swift
//  LearninGAMeelody
//
//  Created by Алексей Щекочихин on 04/01/2017.
//  Copyright © 2017 Ashe Inc. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack{
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "LearninGAMeelody")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

var coreDataStack = CoreDataStack()
var context = coreDataStack.persistentContainer.viewContext


func createGenRepresentaion (_melodyRule: Int16, _modeRule: Int16, _rhythmRule: Int16) -> GenRepresentation {
    let entity =  NSEntityDescription.entity(forEntityName: "GenRepresentation", in: context)
    
    let genRepresentation = NSManagedObject(entity: entity!, insertInto: context)
    
    genRepresentation.setValue(_modeRule, forKey: "modeRule")
    genRepresentation.setValue(_melodyRule, forKey: "melodyRule")
    genRepresentation.setValue(_rhythmRule, forKey: "rhythmicRule")

    return genRepresentation as! GenRepresentation
}

func createGenRepresentation(melodyRules: MelodyRules) -> GenRepresentation {
    return createGenRepresentaion(_melodyRule: melodyRules.melody, _modeRule: melodyRules.mode, _rhythmRule: melodyRules.rhythm)
}

func createNaturalLangugeDescription(_rhythm: String, _mood: String, _melody: String) -> NaturalLanguageDescription {
    let entity =  NSEntityDescription.entity(forEntityName: "NaturalLanguageDescription", in: context)
    
    let naturalLanguageDescription = NSManagedObject(entity: entity!, insertInto: context)
    
    naturalLanguageDescription.setValue(_rhythm, forKey: "rhythm")
    naturalLanguageDescription.setValue(_melody, forKey: "melody")
    naturalLanguageDescription.setValue(_mood, forKey: "mood")
    
    return naturalLanguageDescription as! NaturalLanguageDescription
}
func createNaturalLangugeDescription(userLangDescription: UserLanguageDescription) -> NaturalLanguageDescription {

    return createNaturalLangugeDescription(_rhythm: userLangDescription.rhythmDescription, _mood: userLangDescription.modeDescription, _melody: userLangDescription.melodyDescription)
}



func storeGenRepresentation (_melodyRule: Int16, _modeRule: Int16, _rhythmRule: Int16) {
    
    let entity =  NSEntityDescription.entity(forEntityName: "GenRepresentation", in: context)
    
    let genRepresentation = NSManagedObject(entity: entity!, insertInto: context)
    
    genRepresentation.setValue(_modeRule, forKey: "modeRule")
    genRepresentation.setValue(_melodyRule, forKey: "melodyRule")
    genRepresentation.setValue(_rhythmRule, forKey: "rhythmicRule")
    
    coreDataStack.saveContext()
    print("saved!")

}


func deleteAllDataGen()
{
    let fetchRequest: NSFetchRequest<GenRepresentation>
    fetchRequest = GenRepresentation.fetchRequest()
    let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
    do { try context.execute(DelAllReqVar) }
    catch { print(error) }
}

func deleteAllDataLang()
{
    let fetchRequest: NSFetchRequest<NaturalLanguageDescription>
    fetchRequest = NaturalLanguageDescription.fetchRequest()
    let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
    do { try context.execute(DelAllReqVar) }
    catch { print(error) }
}


// MARK: - Number of Gens

func numberOfGensLearned() -> Int{
    let fetchRequest: NSFetchRequest<GenRepresentation>
    fetchRequest = GenRepresentation.fetchRequest()
    do {
        let results = try context.fetch(fetchRequest)
        return results.count
    } catch let error {
        print(error.localizedDescription)
        return -1
    }
}

func totalNumberOfGens() -> Int{
    return rhythmRulesSet.count*modeRulesSet.count*melodyRulesSet.count
}


func numberOfDescriptLearned() -> Int{
    let fetchRequest: NSFetchRequest<NaturalLanguageDescription>
    fetchRequest = NaturalLanguageDescription.fetchRequest()
    do {
        let results = try context.fetch(fetchRequest)
        return results.count
    } catch let error {
        print(error.localizedDescription)
        return -1
    }
}


