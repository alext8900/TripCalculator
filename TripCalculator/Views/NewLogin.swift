//
//  NewLogin.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import SwiftUI
import FirebaseAuth

struct NewLogin: View {
    
    //MARK: Properties
    @EnvironmentObject var session: SessionStore
    @State private var shouldAnimate = false
    @State private var showLoader = false
    @State private var textfieldsEmptyAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    //MARK: Body
    var body: some View {
        VStack {
            Text(session.registerUser ? "Welcome\nnoobie" : "Welcome\nback")
                .font(.system(size: 50, weight: .semibold, design: .default))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                    ZStack {
                        
                        //MARK: Gradient Circle
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
                
                //MARK: Login Page Form
                ZStack {
                    if showLoader {
                        LoadingView()
                    }
                    
                    
                    
                    VStack(spacing: 15) {
                        
                        Text(session.registerUser ? "Register" : "Login")
                            .font(.system(size: 22, weight: .semibold, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        //MARK: Custom TextField
                        
                        CustomTextField(icon: "envelope",
                                        title: "Email",
                                        hint: "justine@gmail.com",
                                        value: $session.email,
                                        showPassword: .constant(false))
                            .padding(.top, 30)
                        
                        CustomTextField(icon: "lock",
                                        title: "Password",
                                        hint: "Enter Password",
                                        value: $session.password,
                                        showPassword: $session.showPassword)
                            .padding(.top, 10)
                        
                        //MARK: Register re-enter Password
                        if session.registerUser {
                            CustomTextField(icon: "lock",
                                            title: "Verify Password",
                                            hint: "Re-enter Password",
                                            value: $session.reEnterPassword,
                                            showPassword: $session.showReEnterPassword)
                                .padding(.top, 10)
                            
                            CustomTextField(icon: "person",
                                            title: "Name",
                                            hint: "First name",
                                            value: $session.enterName,
                                            showPassword: .constant(false))
                                .padding(.top, 10)
                        }
                        
                        //MARK: Forgot Password Button
                        Button {
                            session.forgotPassword()
                            
                        } label: {
                            
                            Text("Forgot Password?")
                                .font(.system(size: 14, weight: .semibold, design: .default))
                                .foregroundColor(Color(UIColor.systemIndigo))
                        }
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        //MARK: Login Button
                        
                        Button {
                            DispatchQueue.main.async {
                                if session.registerUser {
                                    guard !session.email.isEmpty || !session.password.isEmpty else {
                                        textfieldsEmptyAlert.toggle()
                                        return
                                    }
                                    session.Register(email: session.email, password: session.password) { result, error in
                                        guard result != nil, error == nil else {
                                            isError.toggle()
                                            errorMessage = error?.localizedDescription ?? ""
                                            print(error!.localizedDescription)
                                            return
                                        }
                                        session.email = ""
                                        session.password = ""
                                    }
                                    showLoader.toggle()
                                } else {
                                    guard !session.email.isEmpty else {
                                        textfieldsEmptyAlert.toggle()
                                        return
                                    }
                                    
                                    guard !session.password.isEmpty else {
                                        textfieldsEmptyAlert.toggle()
                                        return
                                    }
                                    session.Login(email: session.email, password: session.password) { result, error in
                                        guard result != nil, error == nil else {
                                            isError = true
                                            showLoader = false
                                            errorMessage = error?.localizedDescription ?? ""
                                            return
                                        }
                                        session.email = ""
                                        session.password = ""
                                    }
                                    
                                    switch showLoader {
                                    case isError:
                                        showLoader.toggle()
                                    default:
                                        showLoader = false
                                    }
                                }
                            }
                            
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
                        .alert("Please enter an email address and a password", isPresented: $textfieldsEmptyAlert, actions: {})
                        .alert(errorMessage, isPresented: $isError, actions: {})
                        .padding(.top, 25)
                        .padding(.horizontal)
                        
                        //MARK: Register User Button
                        
                        Button {
                            withAnimation {
                                session.registerUser.toggle()
                            }
                            
                        } label: {
                            
                            Text(session.registerUser ? "Back to login" : "Create Account")
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
                //MARK: Custom Corners
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
        .onChange(of: session.registerUser) { newValue in
            
            session.email = ""
            session.password = ""
            session.reEnterPassword = ""
            session.enterName = ""
            session.showPassword = false
            session.showReEnterPassword = false
        }
        
        .onChange(of: session.signedIn) { newValue in
            session.email = ""
            session.password = ""
        }
    }
    
    //MARK: Functions
    
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

//MARK: Preview

struct NewLogin_Previews: PreviewProvider {
    static var previews: some View {
        NewLogin()
    }
}
