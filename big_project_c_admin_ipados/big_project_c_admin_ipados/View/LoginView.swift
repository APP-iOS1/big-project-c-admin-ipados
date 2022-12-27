//
//  LoginView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel : LoginViewModel
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var emailCheckText : String = ""
    @State private var passwordCheckText : String = ""
    @State private var isLoadingIndicator : Bool = false
    //ㅇ
    //이메일 규칙
    var isEmailRule : Bool {
        return viewModel.checkEmailRule(email: email)
    }
    //패스워드 규칙
    var isPasswordRule : Bool {
        return viewModel.checkPasswordRule(password: password)
    }
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    VStack(alignment: .leading) {
                        Image("LoginLogo")
                            .offset(x: -10)
                            .padding(.bottom, 10)
                        Text("테킷팅에서 트렌드를 이끄는 세미나의 호스트가 되어주세요!")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.black)
                            .padding(.bottom)
                        Text("문의 (주)멋쟁이사자처럼 담당자 황유진")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color(hex: 0x676767))
                    }
                    .padding(.top, 133)
                    Spacer()
                }
                .padding(.leading, 93)
                Spacer()
    //            .offset(x: -107)
                VStack(alignment: .leading) {
                    Text("관리자용 앱")
                        .font(.system(size: 30, weight: .semibold))
                    Text("제공해드린 아이디와 비밀번호를 입력해주세요.")
                        .font(.system(size: 20, weight: .regular))
                        .padding(.bottom, 18)
                    Rectangle()
                        .frame(width: 395, height: 1)
                        .foregroundColor(Color(hex: 0xECECEC))
                        .padding(.bottom, 32)
                    TextField("이메일 아이디를 입력하세요", text: $email)
                        .padding()
                        .foregroundColor(Color(hex: 0x606060))
                        .frame(width: 395, height: 55)
                        .background(Color(hex: 0xF1F1F1))
                        .cornerRadius(10)
                    Text(emailCheckText)
                    SecureField("비밀번호를 입력하세요", text: $password)
                        .padding()
                        .foregroundColor(Color(hex: 0x606060))
                        .frame(width: 395, height: 55)
                        .background(Color(hex: 0xF1F1F1))
                        .cornerRadius(10)
                    Text(passwordCheckText)
                    Button {
                        print("ㅇㅇ")
                    } label: {
                        Text("로그인 하기")
                            .font(.system(size: 13, weight: .bold))
                            .frame(width: 391, height: 50)
                            .foregroundColor(.white)
                            .background(.black)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 12)
                    Text("로그인이 되지 않거나, 아이디/비밀번호를 잃어버린 경우, \n담당 관리자에게 문의해주세요.")
                        .foregroundColor(Color(hex: 0x6c6c6c))
                        .font(.system(size: 12, weight: .medium))
                }
                .padding(.trailing, 144)
            }
            if isLoadingIndicator {
                ZStack {
                    Color(.systemBackground)
                        .ignoresSafeArea()
                        .opacity(0.8)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .scaleEffect(5)
                }
            }
        }
        .onAppear {
//            isLoadingIndicator = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

////https://www.youtube.com/watch?v=2Jk58S6FiZw
//@State private var isLoadingIndicator : Bool = false
//var body: some View {
//    ZStack {
//        //필요한 기존 ui
//        Text("ㅇㅇ")
//
//        if isLoadingIndicator {
//            ZStack {
//                Color(.systemBackground)
//                    .ignoresSafeArea()
//
//                //indicator
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
//                    .scaleEffect(3)
//            }
//        }
//    }
//    .onAppear { startIndicator() }
//
