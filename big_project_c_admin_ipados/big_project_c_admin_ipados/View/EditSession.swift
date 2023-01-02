//
//  EditSession.swift
//  big_project_c_admin_ipados
//
//  Created by Jae hyuk Yim on 2023/01/02.
//

import SwiftUI
import PhotosUI

struct EditSessionView: View {

    
    @Binding var seminarList: Seminar
    
    // MARK: - Seminar(Sesseion 정보) -> Store에서 나중에 가져올 예정
    @Binding var clickedEditButton: Bool
    
    @ObservedObject var seminar: SeminarStore
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - 이미지 받아오기(PhotoURL)
    @State private var selectedItem: PhotosPickerItem? = nil
    
    @State private var image1: String = ""
    @State private var image2: String = ""
    @State private var image3: String = ""
    
    
    // 이미지 transaction 효과
    private let transaction: Transaction = .init(animation: .linear)
    
    //MARK: - Name (타이틀)
    @State private var name: String = ""
    
    // MARK: - date, startTime, endingTime (Date 피커)
    @State private var date: Date = Date()
    @State private var startingTime: String = ""
    @State private var endingTime: String = ""
    
    
    var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        //한국 시간으로 표시
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        //형태 변환
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }
    
    // MARK: - Category (카테고리)
    @State private var category: [String] = ["프론트","백엔드", "디자인", "블록체인"]
    // 카테고리 피커 돌리기
    @State private var selectedCategory: String = ""
    
    // MARK: - location 피커(3개 장소 임의로)
    @State private var location: String = ""
    @State private var loactionUrl: String = ""
    
    // MARK: - host, hostIntroduction (호스트 인포 - 프로필 사진, 강사소개)
    @State private var host: String = ""
    @State private var hostIntroduce: String = ""
    
    // MARK: - seminarDescription, seminarCurriculum (세미나 상세내용, 상세 커리큘럼)
    @State private var seminarDescription: String = ""
    @State private var seminarCurriculum: String = ""

    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 80) {
                    
                    // MARK: - 세미나 기본정보 타이틀
                    VStack(alignment: .leading) {
                        HStack() {
                            Text("세미나 기본정보")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.accentColor)
                            Spacer()
                            Button{
                                dismiss()
                            } label: {
                                Text("닫기")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .fontWeight(.bold)
                            .background {
                                Color.accentColor
                            }
                            .cornerRadius(10)
                        }
                    }
            
                    
                    // 세미나 기본정보
                    
                    VStack (alignment: .leading) {
                        Text("세미나 타이틀")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        TextField("타이틀을 입력해주세요.", text: $name)
                    }
                    
                    
                    VStack (alignment: .leading)  {
                        Text("대표 이미지")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack {
                            HStack{
                                TextField("이미지 URL을 작성해주세요.", text: $image1)
                            }
                            
                            HStack {
                                AsyncImage(url: URL(string: image1), transaction: transaction, content: imageView)
                                    .frame(width: 100, height: 100)
                                
                            }
                        }
                    }

                    
                    
                    //MARK: - datePicker
                    VStack(alignment: .leading) {
                        
                        Text("일정")
                            .font(.title2)
                            .fontWeight(.bold)
   
                        HStack {
                            //TODO: - 날짜, 시간 DatePicker를 아이콘으로 만들고, 해당 값을 TextLabel로 작성되도록 하기
                            HStack {
                                Image(systemName: "calendar.circle")
                                Text("날짜")
                                DatePicker(selection: $date, displayedComponents: .date) {
                                    Text("date")
                                }
                                Text("\(date, formatter: dateFormatter)")
                            }
                            .labelsHidden()
                            
                            Divider()
                            
                            
                            HStack {
                                
                                Image(systemName: "clock")
                                Text("시작시간")
                                TextField("시작.", text: $startingTime)
                                
                                Spacer()
                                
                                Text("종료시간")
                                TextField("종료.", text: $endingTime)
                            }
                        }
                    }
                    

                    //MARK: - categoryPicker
                    VStack(alignment: .leading) {
                        
                        Text("유형")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 50) {
                            Text("세미나 유형을 선택해주세요")
                                .font(.callout)

                            Picker("세미나 유형을 선택해주세요", selection: $selectedCategory) {
                                ForEach(category, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                    }
                    
         
                    
                    // MARK: - PlacePicker
                    VStack(alignment: .leading) {
                        
                        Text("장소")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 50) {
                            Text("장소를 입력해 주세요")
                                .font(.callout)
                            
                            TextField("세부장소", text: $location)
                            
                            // TODO: - 웹뷰 혹은 URL ? -> 내부 협의 필요
                            Text("장소URL")
                                .font(.callout)

                            TextField("주소", text: $loactionUrl)
                        }
                    }
                    

                    
                    // MARK: - HostInfo ( 호스트 인포 - 프로필 사진, 강사소개)
                
                    
                    VStack (alignment: .leading) {
                        Text("강사 소개")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack {
                            TextField("이미지 URL을 작성해주세요.", text: $host)
                            AsyncImage(url: URL(string: host), transaction: transaction, content: imageView)
                                .frame(width: 100, height: 100)
                            
                        }
                        
                        VStack(alignment: .leading) {
                            TextEditor(text: $hostIntroduce)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .frame(height: 150)
                            
                            if hostIntroduce == "" {
                                Text("내용을 입력 해주세요.")
                                    .opacity(0.5)
                                    .offset(x: 350, y: -95)
                            }
                        }
                    }
                    

                    
                    // MARK: - 세미나 상세내용
                    VStack {
                        VStack(alignment: .leading) {
                            Text("세미나 상세 내용")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                                TextEditor(text: $seminarDescription)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .frame(height: 300)
                                
                                if seminarDescription == "" {
                                    Text("내용을 입력 해주세요.")
                                        .opacity(0.5)
                                        .offset(x: 350, y: -160)
                                }
                         
                        }
                    }
                        
                        // MARK: - 상세 커리큘럼
                    VStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("상세 커리큘럼")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                TextEditor(text: $seminarCurriculum)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .frame(height: 300)
                                
                                if seminarCurriculum == "" {
                                    Text("내용을 입력 해주세요.")
                                        .opacity(0.5)
                                        .offset(x: 350, y: -160)
                                }
                            }
                        }
                    
                       
                        
                        
                        // MARK: - 세미나 등록하기 버튼 추가 (데이터)
                        VStack(alignment: .center) {
                            Button {
                                print("수정 취소")
                                clickedEditButton.toggle()
                            } label: {
                                Text("수정 취소")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .background {
                                Color.accentColor
                            }
                            .cornerRadius(10)

                            
                            
                            Button {
                                
                                seminar.editSeminar(seminar: Seminar(id: seminarList.id,
                                                                     image: seminarList.image,
                                                                     name: seminarList.name,
                                                                     date: seminarList.date,
                                                                     startingTime: seminarList.startingTime,
                                                                     endingTime: seminarList.endingTime,
                                                                     category: seminarList.category,
                                                                     location: seminarList.location,
                                                                     locationUrl: seminarList.locationUrl,
                                                                     host: seminarList.host,
                                                                     hostIntroduction: seminarList.hostIntroduction,
                                                                     seminarDescription: seminarList.seminarDescription,
                                                                     seminarCurriculum: seminarList.seminarCurriculum))
                                
       
                                clickedEditButton.toggle()
                                dismiss()
                                
                            } label: {
                                Text("세미나 수정하기")
                                    .foregroundColor(.white)
                                    .padding()
                                // 등록하기
                            }
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .background {
                                Color.accentColor
                            }
                            .cornerRadius(10)
                            
                        }
                    }
                }
            }
        }
        .padding(.all, 100)
    }
    
    //MARK: - Async image를 나타내는 비동기 메서드
    @ViewBuilder
    private func imageView(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            Image(systemName: "photo")
                .frame(width: 100, height: 100)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                }
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .failure(let error):
            VStack(spacing: 16) {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
            }
        @unknown default:
            Text("Unknown")
                .foregroundColor(.gray)
        }
    }
    
}



//
//
//struct EditSessionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditSessionView(initSeminar: , clickedEditButton: , seminar: <#T##SeminarStore#>)
//    }
//}
//
