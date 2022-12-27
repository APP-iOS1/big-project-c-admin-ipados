//
//  SessionDetailView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct DummySessionData: Identifiable, Hashable {
    let id: UUID = UUID()
    let lecturer: String
    let title: String
    let time: String
    let location: String
    let QnA: [String]
}

let sessionData: [DummySessionData] = [
    DummySessionData(lecturer: "유민영 강사님", title: "타이포그래피 제대로 배워보기", time: "12/31 (일)", location: "멋쟁이사자처럼 광화문", QnA: ["질문티비1", "질문티비2", "질문티비3"]),
    DummySessionData(lecturer: "으니 강사님", title: "타이포그래피 제대로 배워보기1", time: "12/31 (일)", location: "멋쟁이사자처럼 광화문", QnA: ["질문티비1", "질문티비2", "질문티비3"]),
    DummySessionData(lecturer: "쿠니 강사님", title: "타이포그래피 제대로 배워보기2", time: "12/31 (일)", location: "멋쟁이사자처럼 광화문", QnA: ["질문티비1", "질문티비2", "질문티비3"])
    ]

struct SessionDetailView: View {

    let sessionDataSample: [DummySessionData] = sessionData
    
    var sessionDetailId: DummySessionData.ID?
    
    var body: some View {
        VStack {
            List(sessionDataSample) { sample in
                Text(sample.lecturer)
                Text(sample.title)
                    .font(.title)
                HStack {
                    Text(sample.time)
                    Text(sample.location)
                }
            }
        }
    }
}

struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView()
    }
}
