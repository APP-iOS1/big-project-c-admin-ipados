//
//  MemberListView.swift
//  big_project_c_admin_ipados
//
//  Created by yeeunchoi on 2022/12/28.
//

import SwiftUI

struct MemberListView: View {
    
    @StateObject var userStore: UserStore = UserStore()
    @StateObject var seminarStore: SeminarStore = SeminarStore()
    @State private var searchInput: String = ""
//    @State private var sortOrder = [KeyPathComparator(\User.nickname)]
    //뷰에 노출되어야 할 것
    //유저 닉네임(userstore), 유저 이메일(userstore)
    //참석한 세미나(seminarstore)
    //-> 유저스토어의 goSemId key -> 값과 일치하는 id를 가진 seminar문서에 담긴 name value값
    //세미나 참석 여부 -> 추후 논의
    
    //먼저해야할 것
    //Table 형태의 view 구성
    
    
    var body: some View {
        VStack {
            
            List {
                
                Section(header:
                            Text("인원 관리")
                    .font(.system(size: 28))
                    .padding(.bottom, 20)
                    .foregroundColor(.accentColor)
                    .fontWeight(.bold)
                ) {
                    
                    GeometryReader { geometry in
                        HStack {
                            Text("닉네임")
                                .frame(width: geometry.size.width * 0.25)
                            Text("이메일")
                                .frame(width: geometry.size.width * 0.25)
                            Text("신청한 세미나")
                                .frame(width: geometry.size.width * 0.49)
                        }
                        .font(.title2)
                        .frame(maxHeight: .infinity)
                    }
                    
                    ForEach(userStore.userList) { list in
                        
                        MemberListRow(user: list)
                            .frame(height: 100)
                        
                    }
                    .listRowSeparatorTint(.accentColor)
                }
            }
            .scrollContentBackground(.hidden)
            
//            // MARK: -View: 검색창
//            TextField("검색창", text: $searchInput)
                      
//            Table(userStore.userList, sortOrder: $sortOrder) {
//                TableColumn("닉네임", value: \.nickname)
//                TableColumn("이메일", value: \.email)
//                TableColumn("참석한 세미나", value: \.nickname)
//                TableColumn("참석여부", value: \.nickname)
//            }
        }//VStack
        .onAppear {
            userStore.fetchUser()
            seminarStore.fetchSeminar()
        }
    }
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView()
    }
}


//func matchingId(user: User, seminarStore: SeminarStore) -> [String] {
//    
//    var name: [String] = []
//    
//    for semId in user.goSemId {
//        for seminar in seminarStore.seminarList {
//            if semId == seminar.id {
//                name.append(seminar.name)
//                break
//            }
//        }
//    }
//    
//    return name
//}

