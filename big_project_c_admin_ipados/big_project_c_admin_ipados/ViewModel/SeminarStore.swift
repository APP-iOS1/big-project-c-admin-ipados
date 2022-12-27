//
//  SeminarStore.swift
//  Big_Project_C_Customer
//
//  Created by 이종현 on 2022/12/27.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import Firebase


class SeminarStore : ObservableObject {
    // 세미나 배열
    @Published var seminarList : [Seminar] = []
    
    let database = Firestore.firestore()
    
    // 모든 세미나들을 seminarList에 담아줌
    func fetchSeminar() {
        seminarList.removeAll()
        database.collection("Seminar").getDocuments { (snapshot, error) in
            if let snapshot {
                for document in snapshot.documents {
                    let docData = document.data()
                    let id : String = document.documentID
                    let image: [String] = docData["image"] as? [String] ?? []
                    let name: String = docData["name"] as? String ?? ""
                    let date: Date = docData["date"] as? Date ?? Date()
                    let startingTime: String = docData["startingTime"] as? String ?? ""
                    let endingTime: String = docData["endingTime"] as? String ?? ""
                    let category: String = docData["category"] as? String ?? ""
                    let location: String = docData["location"] as? String ?? ""
                    let host: String = docData["host"] as? String ?? ""
                    let hostIntroduction: String = docData["hostIntroduction"] as? String ?? ""
                    let seminarDescription: String = docData["seminarDescription"] as? String ?? ""
                    let seminarCurriculum: String = docData["seminarCurriculum"] as? String ?? ""
                    
                    let seminar = Seminar(id: id, image: image, name: name, date: date, startingTime: startingTime, endingTime: endingTime, category: category, location: location, host: host, hostIntroduction: hostIntroduction, seminarDescription: seminarDescription, seminarCurriculum: seminarCurriculum)
                    
                    self.seminarList.append(seminar)
                }
            }
            print("herer")
            dump(self.seminarList)
        }
    }
    
    // 세미나 작성 완료시 추가됨 (input Seminar 타입으로 다 넣어주시면 됩니다.)
    func addSeminar(_ seminar: Seminar) {
            database.collection("Seminar")
            .document(seminar.id)
                .setData(["id": seminar.id,
                          "image": seminar.image,
                          "name": seminar.name,
                          "startingTime": seminar.startingTime,
                          "endingTime": seminar.endingTime,
                          "category": seminar.category,
                          "location": seminar.location,
                          "host": seminar.host,
                          "hostIntroduction": seminar.hostIntroduction,
                          "seminarDescription": seminar.seminarDescription,
                          "seminarCurriculum": seminar.seminarCurriculum,
                         ])

            //FireStore Data를 READ 해오는 함수 호출
            fetchSeminar()
        }
    
}

//    // 세미나 추가시 필요 정보들
//    @Published var image : [String] = []
//    @Published var name : String = ""
//    @Published var date : Date = Date()
//    @Published var startingTime : String = ""
//    @Published var endingTime : String = ""
//    @Published var category : String = ""
//    @Published var location : String = ""
//    @Published var host : String = ""
//    @Published var hostIntroduction : String = ""
//    @Published var seminarDescription : String = ""
//    @Published var seminarCurriculum : String = ""
