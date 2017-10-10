//
//  CadastroViewController.swift
//  Minha Lista
//
//  Created by Valter Abranches on 07/10/17.
//  Copyright © 2017 Camila e Valter. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {
    
    //MARK: Propriedades e Outlets
    @IBOutlet weak var tvNomeProduto: UITextField!
    @IBOutlet weak var tvUF: UITextField!
    @IBOutlet weak var tvValorUS: UITextField!
    @IBOutlet weak var swCartao: UISwitch!
    @IBOutlet weak var ivImagemProduto: UIImageView!
    @IBOutlet weak var btSubmeter: UIButton!
    
    var produto : Produtos!
    var smallImage: UIImage!
    var pickerView: UIPickerView!
    var dadosPicker:[String] = ["Alberta", "BC",]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if produto != nil {
            tvNomeProduto.text = produto.nome
            tvValorUS.text = "\(produto.valor)"
            swCartao.isSelected = produto.cartao
            btSubmeter.setTitle("Editar", for: .normal)
            
            if let estados = produto.estado{
                tvUF.text = String(describing: estados.estado)
            }
            
            if let imagem = produto.imagem as? UIImage {
                ivImagemProduto.image = imagem
            }
        }
        
        incluirPickerView()
        

    }
    
    //MARK: Metodos de UIResponder
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    //MARK: Actions
    @IBAction func addImagem(_ sender: UIButton) {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let libraryAction = UIAlertAction(title: "Biblioteca", style: .default, handler: { (action: UIAlertAction) in
                self.selectPicture(sourceType: .photoLibrary)
            })
            alert.addAction(libraryAction)
        }
            
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func submeter(_ sender: UIButton) {
        if validarDados() == true {
            alerta(titulo: "Sucesso", mensagem: "Dados validados", botao: "OK")
        }
    }
    
    //MARK: Metodos personalizados
    func validarDados() -> Bool {
        if (tvNomeProduto.text?.isEmpty)! {
            alerta(titulo: "Erro", mensagem: "Informe o nome do produto", botao: "OK")
            return false
        }
        
        if (tvUF.text?.isEmpty)! {
            alerta(titulo: "Erro", mensagem: "Selecione o estado de compra", botao: "OK")
            return false
        }
        
        if (tvValorUS.text?.isEmpty)! {
            alerta(titulo: "Erro", mensagem: "Informe o valor do produto", botao: "OK")
            return false
        }
        
        return true
    }
    
    func alerta(titulo: String, mensagem : String, botao : String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let btOK = UIAlertAction(title: botao, style: .default, handler: nil)
        let btCancela = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(btOK)
        alerta.addAction(btCancela)
        present(alerta, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerControllerSourceType) {
        //Criando o objeto UIImagePickerController
        let imagePicker = UIImagePickerController()
        
        //Definimos seu sourceType através do parâmetro passado
        imagePicker.sourceType = sourceType
        
        //Definimos a MovieRegisterViewController como sendo a delegate do imagePicker
        imagePicker.delegate = self
        
        //Apresentamos a imagePicker ao usuário
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Metodos de PickerView
    func incluirPickerView() {
        pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelar))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(concluir))
        toolbar.items = [btCancel, btSpace, btDone]
        tvUF.inputView = pickerView
        tvUF.inputAccessoryView = toolbar
    }
    
    @objc func cancelar()  {
        tvUF.resignFirstResponder()
    }
    
    @objc func concluir()  {
        tvUF.text = dadosPicker[pickerView.selectedRow(inComponent: 0)]
        cancelar()
    }
    
}

extension CadastroViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dadosPicker.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dadosPicker[row]
    }
}

// MARK: UIImagePickerControllerDelegate
extension CadastroViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]?) {
        
        let smallImage = CGSize(width: 300, height: 280)
        UIGraphicsBeginImageContext(smallImage)
        image.draw(in: CGRect(x: 0, y: 0, width: smallImage.width, height: smallImage.height))
        
        self.smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        ivImagemProduto.image = self.smallImage
        
        dismiss(animated: true, completion: nil)
    }
}



