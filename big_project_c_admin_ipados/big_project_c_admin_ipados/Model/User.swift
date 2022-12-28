//
//  Model.swift
//  Big_Project_C_Customer
//
//  Created by BOMBSGIE on 2022/12/27.
//

import Foundation

struct User : Codable, Identifiable {
    var id : String // 문서 id
    var nickname : String
    var email : String
    var goSemId : [String] // 참석하는 세미나의 고유ID들의 배열
    var isAdmin : Bool
    var uid : String
}




