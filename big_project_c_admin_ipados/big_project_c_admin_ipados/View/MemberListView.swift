//
//  MemberListView.swift
//  big_project_c_admin_ipados
//
//  Created by yeeunchoi on 2022/12/28.
//

import SwiftUI

struct MemberListView: View {
    
    @State private var searchInput: String = ""
    
    var body: some View {
        VStack {
            // MARK: - View: 스샷으로 뷰 대체
            Image("MemberListView")
//                .frame(width: .infinity)
            
//            Text("인원 관리")
//
//            // MARK: -View: 검색창
//            TextField("검색창", text: $searchInput)
        }
    }
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView()
    }
}
