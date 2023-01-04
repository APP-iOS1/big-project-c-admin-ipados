//
//  CameraScanner.swift
//  big_project_c_admin_ipados
//
//  Created by 류창휘 on 2022/12/28.
//

import SwiftUI


struct CameraScanner: View {
    @Binding var startScanning: Bool

    @State var scanIdResult : String = ""
    @State var scanUserNickname : String = ""
    @State var scanUid : String = ""
//    @Binding var seminarID : String
    var seminarID : String
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var attendanceStore : AttendanceStore
    var body: some View {
        NavigationView {

            CameraScannerViewController(startScanning: $startScanning, scanIdResult: $scanIdResult, scanUserNickNameResult: $scanUserNickname, scanUid: $scanUid)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
                .interactiveDismissDisabled(true)
                .onAppear {
                    print("herhehrehrehrherhehrherhehrehr")
                    print(seminarID, "이거")
                }
                .onDisappear {
                    print(seminarID)
                    if scanIdResult != "" && scanUserNickname != "" {
                        attendanceStore.addAttendance(seminarID: seminarID, attendance: Attendance(id: scanIdResult, uid: scanUid, userNickname: scanUserNickname))
                    }
                }
        }
    }
}

//struct CameraScanner_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraScanner(startScanning: .constant(true), scanIdResult: .constant(""), scanUserUidResult: .constant(""), scanUserNickname: .constant(""), semibarID: <#Binding<String>#>)
//    }
//}
