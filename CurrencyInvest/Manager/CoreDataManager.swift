//
//  CoreDataManager.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/4/30.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    
    private init() {
    
    }
    
    func saveToExchangeList (name:String,rate:Double,amount:Double,comment:String) {
        
        //find the container which created at app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let exchangeEntity = NSEntityDescription.entity(forEntityName: "Exchange", in: managedContext) {
            
            let exchange = NSManagedObject(entity: exchangeEntity, insertInto: managedContext)
            
            exchange.setValue(name, forKey: "name")
            exchange.setValue(rate, forKey: "rate")
            exchange.setValue(amount, forKey: "amount")
            exchange.setValue(comment, forKey: "comment")
        }
        
        do {
            try managedContext.save()
        } catch {
            dPrint("save to coredata fails")
        }
        
        
    }
    
    func getExcahngeList () -> [Exchange]{
        
        var exchangeArray = [Exchange]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return exchangeArray
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exchange")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for exchange in result as! [Exchange] {
                exchangeArray.append(exchange)
            }
            
        } catch {
            dPrint("getExcahngeList failed")
        }
        
        return exchangeArray
    }
    
    func deleteOneFromExchangeList(exchange:Exchange) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(exchange)
        
        do {
            try managedContext.save()
        } catch {
            dPrint("deleted but fail to save")
        }
        
        
        
        
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Exchange")
//        deleteFetch.predicate = NSPredicate(format: "amount == %f", amount)
        
//        do {
//            let tryToFetch = try managedContext.fetch(deleteFetch)
//
//            let objectToDelete = tryToFetch[0] as! NSManagedObject
//
//            managedContext.delete(objectToDelete)
//
//            do {
//                try managedContext.save()
//            } catch {
//                print("error to delete : \(error)")
//            }
//
//        } catch {
//
//            print(error)
//
//        }
        
    }
    
    
    func deleteTwo () {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let index = 1
        
        
    }
    
}
