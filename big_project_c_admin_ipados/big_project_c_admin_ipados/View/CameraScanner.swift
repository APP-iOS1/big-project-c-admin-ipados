//
//  CameraScanner.swift
//  big_project_c_admin_ipados
//
//  Created by 류창휘 on 2022/12/28.
//

import SwiftUI


struct CameraScanner: View {
    @Binding var startScanning: Bool

    @Binding var scanIdResult : String
    @Binding var scanUserUidResult : String
    @Binding var scanUserNickname : String
//    @Binding var seminarID : String
    var seminarID : String
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var attendanceStore : AttendanceStore
    var body: some View {
        NavigationView {

            CameraScannerViewController(startScanning: $startScanning, scanIdResult: $scanIdResult, scanUserUidResult: $scanUserUidResult, scanUserNickNameResult: $scanUserNickname)
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
                .onDisappear {
                    print("dd")
                    attendanceStore.addAttendance(seminarID: seminarID, attendance: Attendance(id: scanIdResult, userNickname: scanUserNickname))
                }
        }
    }
}

//struct CameraScanner_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraScanner(startScanning: .constant(true), scanIdResult: .constant(""), scanUserUidResult: .constant(""), scanUserNickname: .constant(""), semibarID: <#Binding<String>#>)
//    }
//}
