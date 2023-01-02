//
//  SessionDetailUserList.swift
//  big_project_c_admin_ipados
//
//  Created by yeeunchoi on 2022/12/28.
//

import SwiftUI

struct SessionDetailUserList: View {
//    @ObservedObject var seminarInfo: SeminarStore
//    @Binding var seminarID : String
//    var seminarID : Seminar.ID?
    var selectedContent : Seminar?
    @EnvironmentObject var attendanceStore : AttendanceStore

    
    var body: some View {
        VStack {
            Text("참석한 사자들 (\(attendanceStore.attendanceUserList.count))")
                .font(.title2)
                .fontWeight(.bold)
            List(attendanceStore.attendanceUserList) { username in
                Text(username.userNickname)
            }
            .listStyle(.plain)
        }
        .onChange(of: selectedContent) { newValue in
            if let selectedContent = newValue {
                print("호출~~")
                attendanceStore.fetchAttendance(seminarID: selectedContent.id)
            }
        }

        
    }
}

//struct SessionDetailUserList_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionDetailUserList()
//    }
//}
