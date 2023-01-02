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
    @Binding var scanIdResult : String
    @Binding var scanUserNickNameResult : String
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
                let details = barcode.payloadStringValue?.components(separatedBy: "\n") ?? ["id", "userUid", "userNickname"]
                parent.scanIdResult = details[0] //id
                parent.scanUserNickNameResult = details[1]
                print("barcode: \(barcode.payloadStringValue ?? "알 수 없음")")
                    dataScanner.stopScanning()
                    dataScanner.dismiss(animated: true)

                
            default:
                break
            }
        }
    }
}

