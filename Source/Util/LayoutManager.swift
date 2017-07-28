//
//  LayoutManager.swift
//  Functional
//
//  Created by Adriano Soares on 28/07/17.
//  Copyright © 2017 Adriano Soares. All rights reserved.
//

import UIKit


class LayoutManager: NSObject {
    static let shared = LayoutManager()

    var navigationColor = UIColor(red:0.18, green:0.19, blue:0.28, alpha:1.00)

    var lightFontColor  = UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.00)



    func styleNavigationBar(navigationBar : UINavigationBar) {
        navigationBar.barTintColor = navigationColor
        navigationBar.tintColor    = lightFontColor
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : lightFontColor]

        
    }

}
