//
//  DashBoardView.swift
//  big_project_c_admin_ipados
//
//  Created by 황예리 on 2023/01/02.
//

import SwiftUI
import Charts

struct DashBoardView: View {
    @State var slices: [(Double, Color)]
    //    var seminar: Seminar
    @ObservedObject var seminarStore: SeminarStore = SeminarStore()
    @EnvironmentObject var attendanceStore: AttendanceStore
    //    @State private var attendanceCountList : [Int] = []
    
    var body: some View {
        ScrollView {
            Grid(alignment: .leading) {
                Text("테켓팅 현황")
                    .padding(.horizontal)
                    .font(.largeTitle).bold()
                // MARK: - 강의별 신청자 참여율 GridRow
                GridRow {
                    VStack(alignment: .leading) {
                        Text("최근 강의 목록")
                            .font(.largeTitle).bold()
                        
                        HStack(spacing: 60) {
                            ForEach(Array(seminarStore.seminarList.enumerated().prefix(3)), id: \.element) { index, column in
                                // FIXME: Pie Graph 수정
                                Canvas { context, size in
                                    let total = slices.reduce(0) { $0 + $1.0 }
                                    context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                                    var pieContext = context
                                    pieContext.rotate(by: .degrees(-90))
                                    let radius = min(size.width, size.height) * 0.48
                                    var startAngle = Angle.zero
                                    for (value, color) in slices {
                                        let angle = Angle(degrees: 360 * (value / total))
                                        let endAngle = startAngle + angle
                                        let path = Path { p in
                                            p.move(to: .zero)
                                            p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                                            p.closeSubpath()
                                        }
                                        pieContext.fill(path, with: .color(color))
                                        
                                        startAngle = endAngle
                                    }
                                }
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: 100, height: 180)
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    // MARK: -강의별 신청자 참여율: 제목과 참석인원 수 들어갈 자리
                                    Text(column.name)
                                        .font(.title2).bold()
                                    
//                                    Text("350명")
//                                        .font(.title).bold()
//                                        .foregroundColor(.orange)
                                }
                            }
                        }
                    }
                    .padding(90)
                    .background(Color("backgroundGray"))
                    .cornerRadius(25)
                }
                
                HStack {
                    // MARK: - 카테고리 별 누적 데이터 GridRow
                    GridRow {
                        VStack(alignment: .leading, spacing: 20) {
                            GridRow {
                                Text("카테고리 별 누적 데이터")
                                    .font(.largeTitle).bold()
                                    .padding(.vertical)
                                HStack(spacing: 120) {
                                    Text("#")
                                    Text("카테고리")
                                    Text("누적된 세미나")
                                    Text("점유율")
                                }
                                .font(.title2).bold()
                                .frame(width: 650)
                                
                                Divider()
                                    .frame(width: 650)
                                
                                ForEach(seminarStore.seminarList.prefix(4)) { column in
                                    HStack(spacing: 70) {
                                        Text("01")
                                            .font(.title3).bold()
                                            .foregroundColor(.orange)
                                            .frame(width: 30)
                                        
                                        Text(column.category)
                                        //띠용?
                                            .font(.title3).bold()
                                            .lineLimit(1)
                                            .frame(width: 120)
                                        
                                        // FIXME: Graph 수정
                                        Chart {
                                            BarMark(
                                                x: .value("Shape Type", data[0].count),
                                                y: .value("Total Count", data[0].type)
                                            )
                                            BarMark(
                                                x: .value("Shape Type", data[0].count),
                                                y: .value("Total Count", data[0].type)
                                            )
                                        }
                                        .frame(width: 200, height: 45)
                                        .chartXAxis(.hidden)
                                        .chartYAxis(.hidden)
                                        
                                        // FIXME: 미완성티비ㅠ 가능티비?
                                        VStack {
                                            Text("40%")
                                                .font(.headline)
                                                .frame(width: 60, height: 30)
                                                .foregroundColor(.orange)
                                                .background(RoundedRectangle(cornerRadius: 4).stroke(.orange, lineWidth: 2))
                                        }
                                        .frame(width: 100)
                                    }
                                }
                            }
                        } // VStack
                        .padding(30)
                        
                        // MARK: - 누적 현황 GridRow
                        GridRow {
                            VStack(alignment: .leading) {
                                Text("누적 현황")
                                    .font(.largeTitle).bold()
                                
                                HStack {
                                    Image(systemName: "person.2.fill")
                                        .resizable()
                                        .frame(width: 80, height: 50)
                                        .foregroundColor(.orange)
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("참여 인원")
                                            .font(.title2)
                                        
                                        HStack {
                                            Text("999,999")
                                                .font(.title).bold()
                                            Text("명")
                                        }
                                    }
                                    
                                }.frame(height: 75)
                                
                                
                                HStack {
                                    Image(systemName: "rectangle.inset.filled.and.person.filled")
                                        .resizable()
                                        .frame(width: 80, height: 50)
                                        .foregroundColor(.orange)
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("세미나")
                                            .font(.title2)
                                        
                                        HStack {
                                            Text("999,999")
                                                .font(.title).bold()
                                            Text("건")
                                        }.frame(height: 75)
                                    }
                                }
                            }
                        }
                        .padding(100)
                    }
                    .background(Color("backgroundGray"))
                    .cornerRadius(25)
                }
            }
            .padding(90)
            .onAppear {
                print("대시보드 탭")
                seminarStore.fetchSeminar()
                seminarStore.fetchSeminarIDList { seminarIDList in
                    attendanceStore.fetchAttendanceUserList(seminarIDList : seminarIDList)
                    //                print(attendanceCountList)
                }
            }
        }
    }
}

//struct DashBoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashBoardView(slices: [
//            (3, .orange),
//            (1, .white)
//        ])
//    }
//}
