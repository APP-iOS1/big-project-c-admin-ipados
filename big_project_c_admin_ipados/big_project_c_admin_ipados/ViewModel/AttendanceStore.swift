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
    
    let database = Firestore.firestore()
    
    func fetchAttendance() {
        attendanceUserList.removeAll()
        database.collection("Attendance").getDocuments { (snapshot, error) in
            if let snapshot {
                for document in snapshot.documents {
                    let docData = document.data()
                    let id : String = document.documentID
                    let uid: String = docData["uid"] as? String ?? ""
                    let userNickName: String = docData["userNickName"] as? String ?? ""
                    
                    let attendance = Attendance(id: id, uid: uid, userNickname: userNickName)
                    
                    self.attendanceUserList.append(attendance)
                }
            }
            print("appendAttendanceUserLIst")
            dump(self.attendanceUserList)
        }
    }
    
    func addAttendance(attendance: Attendance) {
            database.collection("Attendance")
            .document(attendance.id)
                .setData(["id": attendance.id,
                          "uid": attendance.uid,
                          "userNickName": attendance.userNickname,
                         ])

            //FireStore Data를 READ 해오는 함수 호출
        fetchAttendance()
        }
    
}
