//
//  Icon.swift
//  Icone Finder
//
//  Created by Корістувач on 28.04.2020.
//  Copyright © 2020 kolesnikov. All rights reserved.
//

import Foundation

struct Icon {
    let link: String?
    let tags: [String]?
    func tagsToString() -> String {
        var string = ""
        guard let tags = tags else { return string }
        
        for tag in tags {
            string += (tag + ", ")
        }
        if string.count > 2 {
            string = String(string.dropLast(2))
        }
        return string
    }
}

