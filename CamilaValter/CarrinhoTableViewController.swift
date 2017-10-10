//
//  CarrinhoTableViewController.swift
//  Minha Lista
//
//  Created by Valter Abranches on 06/10/17.
//  Copyright © 2017 Camila e Valter. All rights reserved.
//

import UIKit
import CoreData

class CarrinhoTableViewController: UITableViewController {
    
    //MARK: Propriedades
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableViewAutomaticDimension
        
        label.text = "Sua lista está vazia!"
        label.textAlignment = .center
        label.textColor = .black


    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.backgroundView = label
        return 0
    }
}
