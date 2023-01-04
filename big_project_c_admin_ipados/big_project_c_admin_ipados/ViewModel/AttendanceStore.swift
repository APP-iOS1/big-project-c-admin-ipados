//
//  AttendanceStore.swift
//  Big_Project_C_Customer
//
//  Created by 이종현 on 2022/12/27.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import Firebase


class AttendanceStore : ObservableObject {
    // 참석자 배열
    @Published var attendanceUserList : [Attendance] = []
    @Published var dashboardAttendanceUserList : [Int] = []
        
    let database = Firestore.firestore()
    
    func fetchAttendance(seminarID : String) {
        attendanceUserList.removeAll()
        database.collection("Seminar").document("\(seminarID)").collection("Attendance").getDocuments { (snapshot, error) in
            if let snapshot {
                for document in snapshot.documents {
                    let docData = document.data()
//                    let id : String = document.documentID
                    let id: String = docData["id"] as? String ?? ""
                    let userNickName: String = docData["userNickName"] as? String ?? ""
                    let uid: String = docData["uid"] as? String ?? ""
                    
                    let attendance = Attendance(id: id, uid: uid, userNickname: userNickName)
                    
                    self.attendanceUserList.append(attendance)
                    print("\(self.attendanceUserList)")
                }
            }
        }
       
    }
    
    
    func addAttendance(seminarID : String,attendance: Attendance) {
        database.collection("Seminar").document("\(seminarID)").collection("Attendance")
            .document(attendance.uid)
            .setData(["id": attendance.id, "uid": attendance.uid,
                          "userNickName": attendance.userNickname,
                         ])

            //FireStore Data를 READ 해오는 함수 호출
        fetchAttendance(seminarID: seminarID)
        }
    
    func fetchAttendanceUserList(seminarIDList : [String]) {
            self.dashboardAttendanceUserList = []
            for seminarID in seminarIDList {
                database.collection("Seminar").document("\(seminarID)").collection("Attendance")
                    .getDocuments { (snapshot, error) in
                        if let snapshot {
                            var userList = 0
                            for _ in snapshot.documents {
                                userList += 1
                            }
                            self.dashboardAttendanceUserList.append(userList)
                        }
                    }
            }
        }
}

