//
//  FirebaseHelper.swift
//  MyHome
//
//  Created by tran.huu.tan on 7/23/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import FirebaseDatabase
import Firebase
import FirebaseAuth

class FirebaseHelper {
    
    static let shared = FirebaseHelper()
    var userKey = "userKey"
    
    private init() {
        
    }
    
    // MARK: - Authentication
    func signInWithCustomToken(customToken: String) -> Observable<Void> {
        return Observable.create({ (observer) -> Disposable in
            Auth.auth().signIn(withCustomToken: customToken) { (_, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(())
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        })
    }
    
    // MARK: - Get Rooms
    func getRooms() -> Observable<[Room]> {
        return Observable.create({ (observer) -> Disposable in
            let ref = Database.database().reference()
            ref.child("rooms")
                .child(self.userKey)
                .observe(.value, with: { (snapshot) in
                    var rooms: [Room] = []
                    if let allObjects = snapshot.children.allObjects as? [DataSnapshot] {
                        allObjects.forEach { child in
                            if let rs = child.value as? [String: Any],
                                var room = Room(JSON: rs) {
                                room.id = child.key
                                rooms.append(room)
                            }
                        }
                    }
                    observer.onNext(rooms)
                }, withCancel: { (error) in
                    observer.onError(error)
                })
            return Disposables.create()
        })
    }
    
    // MARK: - Add Room
    func addRoom(name: String, price: Double) -> Observable<Void> {
        return Observable.create({ (observer) -> Disposable in
            if !self.userKey.isEmpty && !name.isEmpty {
                let ref = Database.database().reference()
                let data: [String: Any] = [
                    "name": name,
                    "price": price
                ]
                ref.child("rooms")
                    .child(self.userKey)
                    .childByAutoId()
                    .setValue(data, withCompletionBlock: { (error, ref) in
                        if let err = error {
                            observer.onError(err)
                        }
                        
                        observer.onNext(())
                        observer.onCompleted()
                    })
                
            }
            return Disposables.create()
        })
    }
}
