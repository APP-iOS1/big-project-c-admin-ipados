///
//  EuniModel.swift
//  big_project_c_admin_ipados
//
//  Created by yeeunchoi on 2022/12/27.
//

import Foundation

struct Euni: Identifiable, Hashable {
    let id: UUID = UUID()
    let lecturer: String
    let title: String
    let time: String
    let location: String
    let QnA: [String]
}


