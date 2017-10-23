//
//  AjustesViewController.swift
//  CamilaValter
//
//  Created by Valter Abranches on 09/10/17.
//  Copyright © 2017 CamilaValter. All rights reserved.
//

import UIKit
import CoreData

class AjustesViewController: UIViewController {

    @IBOutlet weak var tvCotacao: UITextField!
    @IBOutlet weak var tvImposto: UITextField!
    
    var defaults : UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(carregarConfiguracoes), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        carregarConfiguracoes()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        gravarConfiguracoes()
    }

    @objc func carregarConfiguracoes() {
        defaults = UserDefaults.standard
        
        tvCotacao.text = defaults.string(forKey: "cotacao")
        tvImposto.text = defaults.string(forKey: "iof")
        
    }
    
    func gravarConfiguracoes() {
        defaults = UserDefaults.standard
        
        defaults.set(tvCotacao.text!, forKey: "cotacao")
        defaults.set(tvImposto.text!, forKey: "iof")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }


}
