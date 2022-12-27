//
//  SessionDetailView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct SessionDetailView: View {
    @ObservedObject var euni: EuniStore = EuniStore()
//    var sessionDetailId: Euni.ID?
    
    let euniId: Euni.ID?
    
    var sessionDetailId: Euni? {
        get {
            for sample in euni.eunis {
                if sample.id == euniId {
                    return sample
                }
            }
            return nil
        }
    }
    
    var body: some View {
        VStack {
            
            Text(sessionDetailId?.title ?? "")
            
//            List(euni.eunis) { sample in
//                Text(sample.lecturer)
//                Text(sample.title)
//                    .font(.title)
//                HStack(spacing: 10) {
//                    Text(sample.time)
//                    Text(sample.location)
//                }
//            }
        }
    }
}


//struct SessionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionDetailView()
//    }
//}
