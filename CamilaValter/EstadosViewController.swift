//
//  EstadosViewController.swift
//  CamilaValter
//
//  Created by Valter Abranches on 22/10/17.
//  Copyright © 2017 CamilaValter. All rights reserved.
//

import UIKit
import CoreData

enum ActionType : String {
    case add
    case edit
}

/*
 var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 tableView.estimatedRowHeight = 106
 tableView.rowHeight = UITableViewAutomaticDimension
 
 label.text = "Sua lista está vazia!"
 label.textAlignment = .center
 label.textColor = .black
 
 
 }
*/

class EstadosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Propriedades
    var fetchedResultsController : NSFetchedResultsController<Estados>!
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
    var dataSource : [Estados] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableViewAutomaticDimension
        
        label.text = "Não há estados cadastrados"
        label.textAlignment = .center
        label.textColor = .black
        
        carregarEstados()
        
    }


    //MARK: Actions
    @IBAction func addEstado(_ sender: UIButton) {
        let alerta = UIAlertController(title: sender.titleLabel!.text, message: nil, preferredStyle: .alert)
        
        //TextField de Input
        alerta.addTextField { (textField : UITextField) in
            textField.placeholder = "Nome do Estado"
        }
        alerta.addTextField { (textField : UITextField) in
            textField.placeholder = "Imposto do Estado"
            textField.keyboardType = .decimalPad
        }
        
        //Actions do Alerta
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: { (acao) in
            guard let nome = alerta.textFields![0].text,
                  let imposto = alerta.textFields![1].text,
                self.validaTexto(nome),
                self.validaTexto(imposto)
            else {
                self.alertaPadrao(titulo: "Erro", mensagem: "Dados inválidos", botao: "OK")
                return}
            
            let estado = Estados(context: self.context)
            estado.nome = nome
            estado.imposto = Double(2.1)
            
            do {
                try self.context.save()
                print("Salvei: \(estado.nome ?? "")")
            } catch {}
        }))

        present(alerta, animated: true, completion: nil)
        carregarEstados()
        
    }
    
    func carregarEstados() {
        let fetchRequest : NSFetchRequest<Estados> = Estados.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            dataSource = fetchedResultsController.fetchedObjects!
        } catch {}
        
    }
    
    func validaTexto(_ text: String) -> Bool {
        return !text.isEmpty
    }
    
    func alertaPadrao(titulo: String, mensagem : String, botao : String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let btOK = UIAlertAction(title: botao, style: .default, handler: nil)
        let btCancela = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(btOK)
        alerta.addAction(btCancela)
        present(alerta, animated: true, completion: nil)
    }

    //MARK: Metodos de UIResponder
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    //MARK: Delegate
    
    
    //MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.count != 0 {
            tableView.backgroundView = nil
            return dataSource.count
        } else {
            tableView.backgroundView = label
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row].nome
        
        
        return cell
    }
    
}

extension EstadosViewController : NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}


