////
////  AsyncdataController.swift
////  Chinggu
////
////  Created by Junyoo on 2/26/24.
////...
//
//import CoreData
//
//extension CoreDataManager {
//    
//    func saveContextAsync(throwing errorType: DataControllerError? = nil) throws {
//        do{
//            try bgContext.save()
//        } catch {
//            bgContext.rollback()
//            throw errorType ?? DataControllerError.generalError
//        }
//    }
//    
//    func addComplimentAsync(complimentText: String, groupID: Int16) async throws {
//        try await bgContext.perform {
//            let order = try CoreDataManager.shared.fetchLatestOrder() + 1
//            let newCompliment = ComplimentEntity(context: self.bgContext)
//            
//            newCompliment.compliment = complimentText
//            newCompliment.createDate = Date()
//            newCompliment.order = order
//            newCompliment.id = UUID()
//            newCompliment.groupID = groupID
//            
//            try self.saveContextAsync(throwing: .saveError)
//        }
//    }
//    
//    func deleteComplimentAsync(compliment: ComplimentEntity) async throws {
//        try await bgContext.perform {
//            let orderToDelete = compliment.order
//            self.bgContext.delete(compliment)
//            
//            let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "order > %d", orderToDelete)
//            
//            let complimentsToUpdate = try self.bgContext.fetch(fetchRequest)
//            for complimentToUpdate in complimentsToUpdate {
//                complimentToUpdate.order -= 1
//            }
//            
//            try self.saveContextAsync(throwing: .deleteError)
//        }
//    }
//
//    
//    func fetchComplimentsAsync(request: FetchRequestType) async throws -> [ComplimentEntity] {
//        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
//
//        switch request {
//        case .all:
//            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: false)]
//        case .inGroup(let groupID):
//            fetchRequest.predicate = NSPredicate(format: "groupID == %d", groupID)
//            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: true)]
//        case .byOrder(let order):
//            fetchRequest.predicate = NSPredicate(format: "order == %d", order)
//            fetchRequest.fetchLimit = 1
//        }
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            bgContext.perform {
//                do {
//                    let results = try self.bgContext.fetch(fetchRequest)
//                    continuation.resume(returning: results)
//                } catch {
//                    continuation.resume(throwing: DataControllerError.fetchError)
//                }
//            }
//        }
//    }
//}
