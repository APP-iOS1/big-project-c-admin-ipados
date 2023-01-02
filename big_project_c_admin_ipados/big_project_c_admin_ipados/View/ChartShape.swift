//
//  ChartShape.swift
//  big_project_c_admin_ipados
//
//  Created by 황예리 on 2023/01/02.
//

import SwiftUI

struct ChartShape: Identifiable {
    var type: String
       var count: Double
       var id = UUID()
}

var data: [ChartShape] = [
    .init(type: "Cube", count: 1),
    .init(type: "Cube", count: 2)
]
