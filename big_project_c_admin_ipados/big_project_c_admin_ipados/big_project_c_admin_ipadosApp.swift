//
//  big_project_c_admin_ipadosApp.swift
//  big-project-c-admin-ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct big_project_c_admin_ipados: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {

            ContentView()
                .environmentObject(UserStore())
        }
    }
}
