//
//  EditTestView.swift
//  big_project_c_admin_ipados
//
//  Created by 류창휘 on 2023/01/02.
//

import SwiftUI

struct EditTestView: View {
    @ObservedObject var seminarInfo: SeminarStore
    var seminarID : String
    var body: some View {
        VStack {
            Text("dd")
        }
        .onAppear {
            print("-----------")
            seminarInfo.fetchSeminarID(seminarID: seminarID)
            
        }
    }
}

//struct EditTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTestView()
//    }
//}
