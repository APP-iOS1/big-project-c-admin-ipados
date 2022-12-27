//
//  EuniStore.swift
//  big_project_c_admin_ipados
//
//  Created by yeeunchoi on 2022/12/27.
//

import Foundation

class EuniStore: ObservableObject {
    @Published var eunis: [Euni]
    
    init() {
        eunis = []
    }
}


