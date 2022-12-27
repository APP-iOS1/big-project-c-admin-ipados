//
//  GeneralView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct GeneralView: View {

    @ObservedObject var euni: EuniStore = EuniStore()
    @State private var selectedCategoryId: Euni.ID?

    var body: some View {
        NavigationSplitView {
            List(euni.eunis, selection: $selectedCategoryId) { dataItem in
                VStack(alignment: .leading, spacing: 7) {
                    Text(dataItem.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(dataItem.time)
                    Text(dataItem.location)
                }
                .padding(10)
                
            }
            
        } detail: {
            
            SessionDetailView(euni: euni, euniId: selectedCategoryId)
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
