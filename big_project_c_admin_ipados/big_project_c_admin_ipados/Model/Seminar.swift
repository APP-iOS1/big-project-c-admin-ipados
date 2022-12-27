//
//  Seminar.swift
//  Big_Project_C_Customer
//
//  Created by 이종현 on 2022/12/27.
//

import Foundation

struct Seminar : Codable, Identifiable {
    var id : String // 자동 생성
    var image : [String] // 이미지 배열
    var name : String
    var date : Date
    var startingTime : String
    var endingTime : String
    var category : String
    var location : String
    var host : String
    var hostIntroduction : String
    var seminarDescription : String
    var seminarCurriculum : String
    
    var createdDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko-kr")
            dateFormatter.timeZone = TimeZone(abbreviation: "KST")
            dateFormatter.dateFormat = "yy-MM-dd"

            let dateCreatedAt = date

            return dateFormatter.string(from: dateCreatedAt)
        }
}

struct Question : Codable, Identifiable {
    var id : String
    var question : String
}

struct Attendance : Codable, Identifiable {
    var id : String
    var userUid : String
    var userNickname : String
}
