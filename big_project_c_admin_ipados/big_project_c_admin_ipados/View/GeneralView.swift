//
//  GeneralView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct DummyData: Identifiable, Hashable {
    let id: UUID = UUID()
    let title: String
    let time: String
    let location: String
}

let data: [DummyData] = [
    DummyData(title: "Swift가 궁금해?", time: "2023년 1월 9일 오후 6시~오후8시", location: "멋쟁이사자처럼 광화문"),
    DummyData(title: "으니의 피그마 특강", time: "2023년 2월 27일 오후 2시~오후1시", location: "멋쟁이사자처럼 춘천"),
    DummyData(title: "쿠니의 스토리지 파헤침 당하기", time: "2023년 12월 15일 오후 3시~오후3시", location: "멋쟁이사자처럼 광화문")
    ]

struct GeneralView: View {

    @State private var selectedCategoryId: DummyData.ID?
    @State private var sessionDetailId: DummySessionData.ID?
    
    var body: some View {
        NavigationSplitView {
            List(data, selection: $selectedCategoryId) { dataItem in
                VStack(alignment: .leading, spacing: 7) {
                    Text(dataItem.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(dataItem.time)
                    Text(dataItem.location)
                }
                .padding(10)
                .onTapGesture {
                    sessionDetailId = selectedCategoryId
                }
                
            }
            
        } detail: {
            SessionDetailView(sessionDetailId: selectedCategoryId)
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
