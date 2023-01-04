//
//  GeneralView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct GeneralView: View {

    @ObservedObject var seminarInfo: SeminarStore = SeminarStore()
    
    @State var selectedCategoryId: Seminar.ID?
//    @State private var selectedCategoryIdTest : Seminar.ID
    @State private var isShowingAddSessionView: Bool = false

    var body: some View {
        NavigationSplitView {
            List(seminarInfo.seminarList, selection: $selectedCategoryId) { dataItem in
                VStack(alignment: .leading, spacing: 7) {
                    Text(dataItem.name)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(dataItem.createdDate)
                    Text(dataItem.location)
//                    Divider()
                }
                .padding(10)
            }
            .listStyle(.plain)
            .onAppear {
                seminarInfo.fetchSeminar()
            }
            .refreshable {
                seminarInfo.fetchSeminar()
            }
            .navigationTitle("세미나 목록")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        // MARK: -View: AddSession으로 연결
                        isShowingAddSessionView.toggle()
                        seminarInfo.fetchSeminar()
                    
                    } label: {
                        Text("추가")
                    }
                    

                }
            }
        }
        detail: {
            if let selectedCategoryId {
                SessionDetailView(seminarStore: seminarInfo, seminarId: $selectedCategoryId)
                } else {
                    VStack {
                        Image("LoginLogo")
                        Text("카테고리를 선택해주세요")
                    }
                }
            }        
//        .sheet(isPresented: $isShowingAddSessionView) {
//            AddSessionView(seminar: SeminarStore())
//        }
        .fullScreenCover(isPresented: $isShowingAddSessionView) {
            AddSessionView(seminarStore: seminarInfo)
        }
    }
}

//struct GeneralView_Previews: PreviewProvider {
//    static var previews: some View {
//        GeneralView(selectedCategoryId: .constant(UUID()))
//    }
//}
