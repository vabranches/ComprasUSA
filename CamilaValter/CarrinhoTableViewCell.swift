//
//  CarrinhoTableViewCell.swift
//  CamilaValter
//
//  Created by Valter Abranches on 22/10/17.
//  Copyright © 2017 CamilaValter. All rights reserved.
//

import UIKit

class CarrinhoTableViewCell: UITableViewCell {

    //MARK: Outlets da celula
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbNomeProduto: UILabel!
    @IBOutlet weak var lbValorDolar: UILabel!
    @IBOutlet weak var lbEstadoImposto: UILabel!
    @IBOutlet weak var lbCartaoIOF: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
