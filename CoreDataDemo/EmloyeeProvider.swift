//
//  EmloyeeProvider.swift
//  CoreDataDemo
//
//  Created by Vikas Salian on 26/12/23.
//

import Foundation
import CoreData

class EmloyeeProvider{
    
    private weak var fetchedResultControllerDelegate: NSFetchedResultsControllerDelegate?
    
    init(fetchedResultControllerDelegate: NSFetchedResultsControllerDelegate? = nil) {
        self.fetchedResultControllerDelegate = fetchedResultControllerDelegate
    }
    
    lazy var fetchedResultController: NSFetchedResultsController<CDEmployee> = {
        let fetchRequest: NSFetchRequest<CDEmployee> = CDEmployee.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "firstName", ascending: true)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: PersistantStorage.shared.context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        
        controller.delegate = fetchedResultControllerDelegate
        
        do {
            try  controller.performFetch()
        } catch  {
            debugPrint(error.localizedDescription)
        }
       
        return controller
    }()
}
