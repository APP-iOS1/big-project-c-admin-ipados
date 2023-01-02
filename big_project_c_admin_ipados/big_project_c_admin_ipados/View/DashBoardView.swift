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
    
    var body: some View {
        Grid {
            Spacer()
            
            GridRow {
                // MARK: - 강의별 신청자 참여율 GridRow
                VStack(alignment: .leading) {
                    Text("강의별 신청자 참여율")
                        .font(.largeTitle).bold()
                        .padding()
                    
                    HStack(spacing: 20) {
                        // FIXME: Pie Graph 수정하기
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
                        .frame(width: 250, height: 250)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("강의 타이틀 들어갈 자리입니다.")
                                .font(.title2).bold()
                            
                            Text("50% 참여율")
                                .font(.title).bold()
                                .foregroundColor(.orange)
                            
                        }
                        
                        Divider()
                            .frame(height: 200)
                            .padding()
                        
                    } // HStack
                    
                }
                
                
            } // GridRow
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                GridRow {
                    // MARK: - 카테고리 별 누적 데이터 GridRow
                    VStack(alignment: .leading, spacing: 20) {
                        GridRow {
                            Text("카테고리 별 누적 데이터")
                                .font(.largeTitle).bold()
                            
                            HStack(spacing: 100) {
                                Text("#")
                                Text("카테고리")
                                Text("누적된 세미나")
                                Text("점유율")
                            }
                            .font(.title).bold()
                            
                            HStack(spacing: 100) {
                                Text("01")
                                
                                Text("앱 스쿨")
                                
                                // FIXME: Graph 수정하기, 그래프 겹치기, axis 지우기
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
                                .frame(width: 200, height: 80)
                                
                                // FIXME: 미완성티비..
                                Rectangle()
                                    .frame(width: 50, height: 30)
                            }
                            .font(.title2).bold()
                            
                            HStack(spacing: 100) {
                                Text("02")
                                
                                Text("프론트엔드 스쿨")
                            }
                            .font(.title2).bold()
                            
                            HStack(spacing: 100) {
                                Text("03")
                                
                                Text("백엔드 스쿨")
                            }
                            .font(.title2).bold()
                            
                            HStack(spacing: 100) {
                                Text("04")
                                
                                Text("블록체인 스쿨")
                            }
                            .font(.title2).bold()
                            
                        }
                        
                    } // GridRow
                    
                    Spacer()
                    
                    GridRow {
                        // MARK: - 누적 현황 GridRow
                        VStack(alignment: .leading) {
                            Text("누적 현황")
                                .font(.largeTitle).bold()
                                .padding()
                            
                            HStack {
                                Image(systemName: "person.2.fill")
                                    .resizable()
                                    .frame(width: 80, height: 50)
                                    .foregroundColor(.orange)
                                    .padding()
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("참여 인원 수")
                                        .font(.title2)
                                    
                                    Text("999,999")
                                        .font(.title).bold()
                                    
                                    Text("+10% from yesterday")
                                        .foregroundColor(.orange)
                                        .font(.headline)
                                }
                                .padding()
                            }
                            
                            HStack {
                                Image(systemName: "rectangle.inset.filled.and.person.filled")
                                    .resizable()
                                    .frame(width: 80, height: 50)
                                    .foregroundColor(.orange)
                                    .padding()
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("세미나 수")
                                        .font(.title2)
                                    
                                    Text("999,999")
                                        .font(.title).bold()
                                    
                                    Text("+10% from yesterday")
                                        .foregroundColor(.orange)
                                        .font(.headline)
                                }
                                .padding()
                            }
                        }
                    }
                    
                    Spacer()
                    
                } // GridRow
                
                Spacer()
            }
        }
    }
}
    
    struct DashBoardView_Previews: PreviewProvider {
        static var previews: some View {
            DashBoardView(slices: [
                (2, .red),
                (3, .orange),
                (4, .yellow),
                (1, .green),
                (5, .blue),
                (4, .indigo),
                (2, .purple)
            ])
        }
    }
