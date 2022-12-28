//
//  CameraScannerViewController.swift
//  big_project_c_admin_ipados
//
//  Created by 류창휘 on 2022/12/28.
//


import SwiftUI
import UIKit
import VisionKit
struct CameraScannerViewController: UIViewControllerRepresentable {
    
    @Binding var startScanning: Bool
//    @Binding var scanResult: String
        @Binding var scanUserResult: String
        @Binding var scanEmailResult: String
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let viewController = DataScannerViewController(
            recognizedDataTypes: [.barcode()],
            qualityLevel: .fast,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: false,
            isHighlightingEnabled: true)
        
        viewController.delegate = context.coordinator

        return viewController
    }
    
    func updateUIViewController(_ viewController: DataScannerViewController, context: Context) {
        if startScanning {
            try? viewController.startScanning()
        } else {
            viewController.stopScanning()
        }
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: CameraScannerViewController
        init(_ parent: CameraScannerViewController) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .barcode(let barcode):
                let details = barcode.payloadStringValue?.components(separatedBy: "\n") ?? ["알 수 없는 유저", "알 수 없는 이메일"]
                guard details.count == 2 else { return }
                parent.scanUserResult = details[0]
                print(details[0])
                parent.scanEmailResult = details[1]
                print("barcode: \(barcode.payloadStringValue ?? "알 수 없음")")
                    dataScanner.stopScanning()
                    dataScanner.dismiss(animated: true)
                
//                parent.scanResult = barcode.payloadStringValue ?? "알 수 없음"
            default:
                break
            }
        }
    }
}
