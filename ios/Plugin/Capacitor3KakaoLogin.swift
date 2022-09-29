import Foundation
import Capacitor

import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKTemplate


@objc public class Capacitor3KakaoLogin: NSObject {
    @objc public func kakaoLogin(_ call: CAPPluginCall) -> Void {
        
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    call.reject("error")
                }
                else {

                    call.resolve([
                        "value": oauthToken?.accessToken ?? ""
                    ])
                    
                }
            }
        }
        else{
            
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                        call.reject("error")
                    }
                    else {

                        call.resolve([
                            "value": oauthToken?.accessToken ?? ""
                        ])
                    }
                }
            
        }
    }
    
    @objc public func kakaoLogout(_ call: CAPPluginCall) -> Void {

        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
                call.reject("error")
            }
            else {

                call.resolve([
                    "value": "done"
                ])
            }
        }
    }
    
    
    
    @objc public func kakaoUnlink(_ call: CAPPluginCall) -> Void {

        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
                call.reject("error")
            }
            else {

                call.resolve([
                    "value": "done"
                ])
            }
        }
    }
    
    
    @objc public func sendLinkFeed(_ call: CAPPluginCall) -> Void {

    }

    @objc public func me(_ call: CAPPluginCall) -> Void {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
                call.reject("error")
            }
            else {
                call.resolve([
                    "id": user?.id,
                    "email": user?.kakaoAccount?.email,
                    "nickname": user?.kakaoAccount?.profile?.nickname
                ])
            }
        }
    }
}
