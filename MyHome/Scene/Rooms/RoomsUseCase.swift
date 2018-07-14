//
// RoomsUseCase.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

protocol RoomsUseCaseType {
    func getRoomList() -> Observable<[Room]>
}

struct RoomsUseCase: RoomsUseCaseType {
    func getRoomList() -> Observable<[Room]> {
        // TODO: Mock
        let price: Double = 2000000
        let name: String = "Phòng"
        
        let rooms = [
            Room().with {
                $0.id = "R-301"
                $0.name = "\(name) 301"
                $0.price = price
                $0.userId = "ID-001"
            },
            Room().with {
                $0.id = "R-302"
                $0.name = "\(name) 302"
                $0.price = price
                $0.userId = "ID-002"
            },
            Room().with {
                $0.id = "R-303"
                $0.name = "\(name) 303"
                $0.price = price
            },
            Room().with {
                $0.id = "R-304"
                $0.name = "\(name) 304"
                $0.price = price
            },
            Room().with {
                $0.id = "R-401"
                $0.name = "\(name) 401"
                $0.price = price
            },
            Room().with {
                $0.id = "R-402"
                $0.name = "\(name) 402"
                $0.price = price
            },
            Room().with {
                $0.id = "R-403"
                $0.name = "\(name) 403"
                $0.price = price
            },
            Room().with {
                $0.id = "R-404"
                $0.name = "\(name) 404"
                $0.price = price
            },
            Room().with {
                $0.id = "R-501"
                $0.name = "\(name) 501"
                $0.price = price
            },
            Room().with {
                $0.id = "R-502"
                $0.name = "\(name) 502"
                $0.price = price
            },
            Room().with {
                $0.id = "R-503"
                $0.name = "\(name) 503"
                $0.price = price
            },
            Room().with {
                $0.id = "R-504"
                $0.name = "\(name) 504"
                $0.price = price
            },
            Room().with {
                $0.id = "R-601"
                $0.name = "\(name) 601"
                $0.price = price
            },
            Room().with {
                $0.id = "R-602"
                $0.name = "\(name) 602"
                $0.price = price
            }
        ]
        return Observable.just(rooms)
    }
}

