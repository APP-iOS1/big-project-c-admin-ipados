//
//  CameraScanner.swift
//  big_project_c_admin_ipados
//
//  Created by 류창휘 on 2022/12/28.
//

import SwiftUI


struct CameraScanner: View {
    @Binding var startScanning: Bool
    @Binding var scanUserResult: String
    @Binding var scanEmailResult: String {
        didSet {
            print(scanEmailResult)
            if scanEmailResult != "알 수 없는 유저" {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            CameraScannerViewController(startScanning: $startScanning, scanUserResult: $scanUserResult, scanEmailResult: $scanEmailResult)
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
        }
    }
}

struct CameraScanner_Previews: PreviewProvider {
    static var previews: some View {
        CameraScanner(startScanning: .constant(true), scanUserResult: .constant(""), scanEmailResult: .constant(""))
    }
}
