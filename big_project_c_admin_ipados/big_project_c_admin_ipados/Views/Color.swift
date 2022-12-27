//
//  Color.swift
//  big_project_c_admin_ipados
//
//  Created by yeeunchoi on 2022/12/27.
//

import Foundation
import SwiftUI

extension Color {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0
        )
    }
}
