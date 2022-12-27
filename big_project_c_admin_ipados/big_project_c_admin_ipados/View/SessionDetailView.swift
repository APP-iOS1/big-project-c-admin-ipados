//
//  SessionDetailView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct SessionDetailView: View {
//    var sessionDetailId: DummySessionData.ID?
    @ObservedObject var euni: EuniStore = EuniStore()
    
    var body: some View {
        VStack {
            
//            List(euni) { sample in
//                Text(sample.lecturer)
//                Text(sample.title)
//                    .font(.title)
//                HStack {
//                    Text(sample.time)
//                    Text(sample.location)
//                }
//            }
        }
    }
}

struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView()
    }
}
