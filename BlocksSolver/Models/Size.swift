//
//  Size.swift
//  BlocksSolver
//
//  Created by Anil Puttabuddhi on 06/08/2020.
//  Copyright © 2020 Suvarnasoft. All rights reserved.
//

import Foundation

struct Size: Equatable {
    let rows: Int
    let columns: Int

    init(_ rows: Int, _ columns: Int) {
        self.rows = rows
        self.columns = columns
    }

    var asString: String {
        "\(rows)_\(columns)"
    }
}
