//
//  EuniStore.swift
//  big_project_c_admin_ipados
//
//  Created by yeeunchoi on 2022/12/27.
//

import Foundation

class EuniStore: ObservableObject {
    @Published var eunis: [Euni]
    
    init() {
        eunis = [
            Euni(lecturer: "민영 강사님", title: "Swift가 궁금해?", time: "2023년 1월 9일 오후 6시~오후8시", location: "멋쟁이사자처럼 광화문", QnA: ["질문티비1", "질문티비2", "질문티비3"]),
            Euni(lecturer: "민영 강사님", title: "으니의 피그마 특강", time: "2023년 2월 27일 오후 2시~오후1시", location: "멋쟁이사자처럼 춘천", QnA: ["질문티비1", "질문티비2", "질문티비3"]),
            Euni(lecturer: "민영 강사님", title: "쿠니의 스토리지 파헤침 당하기", time: "2023년 12월 15일 오후 3시~오후3시", location: "멋쟁이사자처럼 광화문", QnA: ["질문티비1", "질문티비2", "질문티비3"])
            ]
    }
}


