//
//  MemberListRow.swift
//  big_project_c_admin_ipados
//
//  Created by 조운상 on 2023/01/02.
//

import SwiftUI

//뷰에 노출되어야 할 것
//유저 닉네임(userstore), 유저 이메일(userstore)
//참석한 세미나(seminarstore)
//-> 유저스토어의 goSemId key -> 값과 일치하는 id를 가진 seminar문서에 담긴 name value값
//세미나 참석 여부 -> 추후 논의



struct MemberListRow: View {
    var user: User
    @StateObject var seminarStore: SeminarStore = SeminarStore()
    
    var body: some View {
            GeometryReader { geometry in
                HStack(alignment:.center) {
                    
                    VStack {
                        Text(user.nickname)
                    }
                    .frame(width: geometry.size.width * 0.20)
                    
                    VStack {
                        Text(user.email)
                    }
                    //                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(width: geometry.size.width * 0.20)
                    
                    VStack {
                        if !matchingId(user: user, seminarStore: seminarStore).isEmpty {
                            ForEach(matchingId(user: user, seminarStore: seminarStore), id: \.self) { seminarName in
                                
                                Text(seminarName)
                                
                            }
                        } else {
                            Text("")
                        }
                    }
                    .frame(width: geometry.size.width * 0.39)
                    
                    VStack {
                        if user.isAdmin {
                            Text("YES")
                        } else {
                            Text("NO")
                        }
                    }
                    .frame(width: geometry.size.width * 0.20)
                }
                .frame(maxHeight: .infinity)
                .onAppear {
                    seminarStore.fetchSeminar()
            }
        }
    }
}

struct MemberListRow_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            MemberListRow(user: User(id: "", nickname: "닉네임", email: "ggg@ggg.com", goSemId: ["453ED6EE-3134-4CB7-9F08-2000DF9A58BF","5009D6BB-11A8-406B-9EC1-0D86911AA955", "536B3BD9-C3B4-4993-BD9B-1C4F81E87DB3", "1484F739-BD5F-4E73-B87C-EFCF9DCC3F4B","D0FFBA9C-4091-4128-AE1E-3D372009FB0F"], isAdmin: true, uid: ""))
        }
    }
}

func matchingId(user: User, seminarStore: SeminarStore) -> [String] {
    
    var name: [String] = []
    
    for semId in user.goSemId {
        for seminar in seminarStore.seminarList {
            if semId == seminar.id {
                name.append(seminar.name)
                break
            }
        }
    }
    
    return name
}
