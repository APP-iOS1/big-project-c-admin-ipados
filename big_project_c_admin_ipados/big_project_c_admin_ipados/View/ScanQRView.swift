//
//  ScanQRView.swift
//  big_project_c_admin_ipados
//
//  Created by 류창휘 on 2022/12/28.
//

import SwiftUI
import VisionKit
struct ScanQRView: View {
    @State private var showCameraScannerView = false
    @State private var isDeviceCapacity = false
    @State private var showDeviceNotCapacityAlert = false
    @State private var scanUserResults: String = "아직 유저 결과가 없습니다"
    @State private var scanEmailResult : String = "아직 이메일 결과가 없습니다."
    @State private var scanResults: String = ""
    //    let details = result.string?.components(separatedBy: "\n")
    var body: some View {
        VStack {
            Text(scanUserResults)
                .padding()
            Text(scanEmailResult)
            Button {
                if isDeviceCapacity {
                    self.showCameraScannerView = true
                } else {
                    self.showDeviceNotCapacityAlert = true
                }
            } label: {
                Text("Tap to Scan Documents")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $showCameraScannerView) {
            CameraScanner(startScanning: $showCameraScannerView, scanUserResult: $scanUserResults, scanEmailResult: $scanEmailResult)
//            CameraScanner(startScanning: $showCameraScannerView, scanResult: $scanResults)
        }
        .alert("스캐너 사용불가", isPresented: $showDeviceNotCapacityAlert, actions: {})
        .onAppear {
            isDeviceCapacity = (DataScannerViewController.isSupported && DataScannerViewController.isAvailable)
        }
    }
}

struct ScanQRView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRView()
    }
}

