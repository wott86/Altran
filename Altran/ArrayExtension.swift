//
//  ArrayExtension.swift
//  Altran
//
//  Created by Cesar Vilera on 1/9/17.
//  Copyright © 2017 Cesar Vilera. All rights reserved.
//

import Foundation

protocol _StringType {}
extension String: _StringType {}

extension Array where Element: _StringType {
    func toString() -> String? {
        var string: String? = String()
        for item in self {
            if (string?.characters.count)! > 0 {
                string! += ", "
            }
            string! += item as! String
        }
        return string
    }
}
