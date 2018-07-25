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
    
    // MARK: - Get Room Infomation
    func getRoomInfo(with roomId: String) -> Observable<Room?> {
        guard !roomId.isEmpty else {
            return Observable.just(nil)
        }
        
        return Observable.create({ (observer) -> Disposable in
            let ref = Database.database().reference()
            ref.child("rooms")
                .child(self.userKey)
                .child(roomId)
                .observe(.value, with: { (snapshot) in
                    if snapshot.exists() {
                        if let rs = snapshot.value as? [String: Any],
                            var room = Room(JSON: rs) {
                            room.id = snapshot.key
                            observer.onNext(room)
                            observer.onCompleted()
                        }
                    }
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
    
    // MARK: - Rent Room
    func rentRoom(room: Room, user: User) -> Observable<Void> {
        return Observable.create({ (observer) -> Disposable in
            let userRef = Database.database().reference()
            let userData: [String: Any] = [
                "name": user.name,
                "phoneNumber": user.phoneNumber
            ]
            
            // Add User
            userRef.child("users")
                .childByAutoId()
                .setValue(userData, withCompletionBlock: { (error, refA) in
                    if let err = error {
                        observer.onError(err)
                    }
                    let roomData: [String: Any] = [
                        "price": room.price,
                        "oldElectricityUsed": room.oldElectricityUsed,
                        "numberPeoples": room.numberPeoples,
                        "deposits": room.deposits,
                        "note": room.note,
                        "startDate": room.startDate ?? "",
                        "isUseInternet": room.isUseInternet,
                        "renterId": refA.key
                    ]
                    
                    // Update Room Info
                    let roomRef = Database.database().reference()
                    roomRef.child("rooms")
                        .child(self.userKey)
                        .child(room.id)
                        .updateChildValues(roomData, withCompletionBlock: { (error, refB) in
                            if let err = error {
                                observer.onError(err)
                            }
                            
                            observer.onNext(())
                            observer.onCompleted()
                        })
                    
                })
            return Disposables.create()
        })
    }
}
