//
//  NewLogin.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import SwiftUI
import FirebaseAuth

struct NewLogin: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    @State private var isLoading = false
    @State private var showLoader = false
    var body: some View {
            VStack {
                
                Text(loginData.registerUser ? "Welcome\nnoobie" : "Welcome\nback")
                        .font(.system(size: 50, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: getRect().height / 3.5)
                        .padding()
                        .background(
                            ZStack {
                                
                                // Gradient Circle
                                LinearGradient(colors: [
                                    Color.pink,
                                    Color.pink.opacity(0.8),
                                    Color(UIColor.systemIndigo)
                                ], startPoint: .top, endPoint: .bottom)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                    .padding(.trailing)
                                    .offset(y: -25)
                                    .ignoresSafeArea()
                                
                                Circle()
                                    .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                    .frame(width: 30, height: 30)
                                    .blur(radius: 2)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                    .padding(30)
                                
                                Circle()
                                    .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                    .frame(width: 23, height: 23)
                                    .blur(radius: 2)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    .padding(.leading, 30)
                            }
                        )
                    
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // Login Page Form
                    ZStack {
                        if showLoader {
                            Circle()
                                .trim(from: 0, to: 0.7)
                                .stroke(Color(UIColor.systemIndigo), lineWidth: 5)
                                .frame(width: 100, height: 100)
                                .rotationEffect(Angle(degrees:  isLoading ? 360 : 0))
                                .animation(Animation.default.repeatForever(autoreverses: false))
                                .onAppear {
                                    self.isLoading = true
                                }
                        }
                        
                        VStack(spacing: 15) {
                            
                            Text(loginData.registerUser ? "Register" : "Login")
                                .font(.system(size: 22, weight: .semibold, design: .default))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Custom Text Field
                            
                            CustomTextField(icon: "envelope",
                                            title: "Email",
                                            hint: "justine@gmail.com",
                                            value: $loginData.email,
                                            showPassword: .constant(false))
                                .padding(.top, 30)
                            
                            CustomTextField(icon: "lock",
                                            title: "Password",
                                            hint: "Enter Password",
                                            value: $loginData.password,
                                            showPassword: $loginData.showPassword)
                                .padding(.top, 10)
                            
                            // Register Reenter Password
                            if loginData.registerUser {
                                CustomTextField(icon: "person",
                                                title: "Name",
                                                hint: "First name",
                                                value: $loginData.enterName,
                                                showPassword: .constant(false))
                                    .padding(.top, 10)
                                
                                CustomTextField(icon: "lock",
                                                title: "Re-Enter Password",
                                                hint: "Verify Password",
                                                value: $loginData.reEnterPassword,
                                                showPassword: $loginData.showReEnterPassword)
                                    .padding(.top, 10)
                            }
                            
                            // Forgot Password Button...
                            Button {
                                loginData.forgotPassword()
                                
                            } label: {
                                
                                Text("Forgot Password?")
                                    .font(.system(size: 14, weight: .semibold, design: .default))
                                    .foregroundColor(Color(UIColor.systemIndigo))
                            }
                            .padding(.top, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Login Button
                            
                            Button {
                                DispatchQueue.main.async {
                                    if loginData.registerUser {
                                        loginData.Register()
                                        showLoader.toggle()
                                    } else {
                                        loginData.Login(email: loginData.email, password: loginData.password)
//                                        if loginData.signedIn {
//                                            loginData.Login(email: loginData.email, password: loginData.password)
//                                            showLoader.toggle()
                                        
                                    }
                                }
//                               showLoader.toggle()
                                
                            } label: {
                                
                                Text("Login")
                                    .font(.system(size: 17, weight: .bold, design: .default))
                                    .padding(.vertical, 20)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color.white)
                                    .background(Color(UIColor.systemIndigo))
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                            
                            // Register User Button
                            
                            Button {
                                withAnimation {
                                    loginData.registerUser.toggle()
                                }
                                
                            } label: {
                                
                                Text(loginData.registerUser ? "Back to login" : "Create Account")
                                    .font(.system(size: 14, weight: .semibold, design: .default))
                                    .foregroundColor(Color(UIColor.systemIndigo))
                            }
                            .padding(.top, 8)

                        }
                        .padding(30)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color.white
                    // Applying custom corners
                        .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                        .ignoresSafeArea()
                )
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color(UIColor.systemIndigo)
            )
            
            // Clearing data when changes
            // optional
            .onChange(of: loginData.registerUser) { newValue in
                
                loginData.email = ""
                loginData.password = ""
                loginData.reEnterPassword = ""
                loginData.enterName = ""
                loginData.showPassword = false
                loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint:
        String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.system(size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") &&
                !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
                    .disableAutocorrection(true)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
                    .disableAutocorrection(true)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        
        .overlay(
            Group {
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Image(systemName: showPassword.wrappedValue ? "eye" : "eye.slash")
                            .foregroundColor(Color(UIColor.systemIndigo))
                    })
                        .offset(y: 10)
                }
                
            }
            ,alignment: .trailing
        )
    }
}

struct NewLogin_Previews: PreviewProvider {
    static var previews: some View {
        NewLogin()
    }
}
