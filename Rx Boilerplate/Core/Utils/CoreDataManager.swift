//
//  CoreDataManager.swift
//
//  Created by Aaron Lee on 2021/07/06.
//

import Foundation
import CoreData

/// CoreData 매니저
final class CoreDataManager {
    
    private init() { }
    
    // MARK: - Public Properties
    
    static let shared = CoreDataManager()
    
    /// Container
    func persistentContainer(type: EntityType) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: type.rawValue)
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }
    
    // MARK: - Helpers
    
    /// 저장
    func save(type: EntityType) {
        let context = persistentContainer(type: type).viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    /// 전체 삭제
    @discardableResult
    func deleteAll(type: EntityType, request: NSFetchRequest<NSFetchRequestResult>) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = request
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.persistentContainer(type: type).viewContext.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
}
