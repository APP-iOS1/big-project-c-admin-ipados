//
//  SessionDetailUserList.swift
//  big_project_c_admin_ipados
//
//  Created by yeeunchoi on 2022/12/28.
//

import SwiftUI

struct SessionDetailUserList: View {
//    @ObservedObject var seminarInfo: SeminarStore
    
    let dummyUser: [String] = [
        "또리",
        "쿠니",
        "예니",
        "휘휘",
        "노직",
        "허미니",
        "소미니",
        "후니",
        "억지니",
        "영이",
        "뚜리",
        "하노이베트남왕세자"
    ]
    
    var body: some View {
        VStack {
            Text("참석한 사자들 (\(dummyUser.count))")
                .font(.title2)
                .fontWeight(.bold)
            List(dummyUser, id: \.self) { username in
                Text(username)
            }
            .listStyle(.plain)
        }
    }
}

struct SessionDetailUserList_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailUserList()
    }
}
