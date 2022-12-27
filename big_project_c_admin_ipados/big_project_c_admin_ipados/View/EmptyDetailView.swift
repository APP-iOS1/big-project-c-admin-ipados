//
//  EmptyView.swift
//  big_project_c_admin_ipados
//
//  Created by yeeunchoi on 2022/12/27.
//

import SwiftUI


struct EmptyDetailView: View {
    var body: some View {
        Image("EmptyDetailViewLogo")
            .frame(width: 250)
            .aspectRatio(contentMode: .fit)
            .padding(.bottom, 22)
        Text("세미나를 관리해보세요! \n세미나의 정보 관리와 Q&A를 확인할 수 있습니다.")
            .font(.title)
            .fontWeight(.medium)
    }
}

struct EmptyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyDetailView()
    }
}
