//
//  UIViewController+CoreData.swift
//  CamilaValter
//
//  Created by Valter Abranches on 22/10/17.
//  Copyright © 2017 CamilaValter. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController{
    var appDelegate : AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    var context : NSManagedObjectContext{
        return appDelegate.persistentContainer.viewContext
    }
}
