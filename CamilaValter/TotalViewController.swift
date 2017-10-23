//
//  TotalViewController.swift
//  CamilaValter
//
//  Created by Valter Abranches on 23/10/17.
//  Copyright © 2017 CamilaValter. All rights reserved.
//

import UIKit
import CoreData
class TotalViewController: UIViewController {

    
    @IBOutlet weak var lbValorDolar: UILabel!
    
    @IBOutlet weak var lbValorReal: UILabel!
    
    var fetchedProductsController: NSFetchedResultsController<Produtos>!
    var products = [Produtos]()
    
    var totalDolar: Double = 0
    var totalReal: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbValorReal.text = "0.00"
        lbValorDolar.text = "0.00"
        
        loadProducts()
    }

    func loadProducts() {
        let fetchRequest: NSFetchRequest<Produtos> = Produtos.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedProductsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedProductsController.delegate = self
        do {
            try fetchedProductsController.performFetch()
            self.products = fetchedProductsController.fetchedObjects!
            updateLabels()
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateLabels() {
        let cotacao = Double(UserDefaults.standard.string(forKey: "cotacao") ?? "0")!
        
        totalDolar = 0
        totalReal = 0
        
        for p in products {
            
            totalDolar += p.valor
            totalReal += p.valor * cotacao
            
            if p.cartao {
                totalReal += p.valor * (p.estado!.imposto/100)
            }
            
        }
        
        lbValorDolar.text = String(format: "%.2f", totalDolar)
        lbValorReal.text = String(format: "%.2f", totalReal)
    }
}

extension TotalViewController : NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        products = fetchedProductsController.fetchedObjects!
        updateLabels()
    }
}
