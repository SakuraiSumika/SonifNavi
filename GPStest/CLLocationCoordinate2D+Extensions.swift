//
//  CLLocationCoordinate2D+Extensions.swift
//  MapKitSamplerForiOS17
//
//  Created by yuji on 2024/03/13.
//

import MapKit

extension CLLocationCoordinate2D {
    
    static let tokyoStation = CLLocationCoordinate2D(latitude: 35.681271031625556, longitude: 139.76710334029735)

    static let shinagawaStation = CLLocationCoordinate2D(latitude: 35.6284756, longitude: 139.7361848)

    static let tokyoStationStreet = CLLocationCoordinate2D(latitude: 35.679981237178694, longitude: 139.76897015768628)

    static let nagoyaStation = CLLocationCoordinate2D(latitude: 35.171046524929345, longitude: 136.88292091775608)

    static let osakaStation = CLLocationCoordinate2D(latitude: 34.70257357671039, longitude: 135.4959720556559)

    static let hakataStation = CLLocationCoordinate2D(latitude: 33.590225024456885, longitude: 130.42114956628524)
    
    static let mise = CLLocationCoordinate2D(latitude: 36.10941686386272, longitude: 140.10665258411916)
    
    static let myhome = CLLocationCoordinate2D(latitude: 36.09416957547146, longitude: 140.11107840105103) 
    
    static let lab = CLLocationCoordinate2D(latitude: 36.110650698421686, longitude:  140.10001861670477)
    
    static let tabacopoint = CLLocationCoordinate2D(latitude: 36.11003765397628, longitude:  140.09934372437132)
    
    static let yubune1 = CLLocationCoordinate2D(latitude: 35.93033998582223, longitude:  140.20189847084293)
    
    static let yubune2 = CLLocationCoordinate2D(latitude: 35.93034403705432, longitude:   140.20223572752263)
    
    public struct Route {
        let distination: CLLocationCoordinate2D
        let junction: CLLocationCoordinate2D
        let direction: Int
    }
    
    static let hirasuna = Route(
        distination:CLLocationCoordinate2D(latitude: 36.09762688481756, longitude:   140.10372908287408),
        junction:CLLocationCoordinate2D(latitude: 36.09686816086933, longitude:   140.10386592544995),
        direction: 80)
    
    static let kasugasyukusya = Route(
        distination:CLLocationCoordinate2D(latitude: 36.08776039336891, longitude:   140.10672521479395),
        junction:CLLocationCoordinate2D(latitude: 36.08748845118477, longitude:   140.10693412423558),
        direction: -80)
    
    static let kasugainovation = Route(
        distination:CLLocationCoordinate2D(latitude: 36.08770182587376, longitude:   140.10654578268387),
        junction:CLLocationCoordinate2D(latitude: 36.087408087959815, longitude:   140.10677412520226),
        direction: -80)
    
    static let kasugaroopright = Route(
        distination:CLLocationCoordinate2D(latitude: 36.08559626153422, longitude:   140.10708633864732),
        junction:CLLocationCoordinate2D(latitude: 36.08552893204956, longitude:   140.10682171924014),
        direction: 60)
    
    static let kasugaroopleft = Route(
        distination:CLLocationCoordinate2D(latitude: 36.085774381258915, longitude:   140.1067634877635),
        junction:CLLocationCoordinate2D(latitude: 36.08552893204956, longitude:   140.10682171924014),
        direction: -40)
    
    static let kasugaparking = Route(
        distination:CLLocationCoordinate2D(latitude: 36.08537549286466, longitude:   140.10691870453454),
        junction:CLLocationCoordinate2D(latitude: 36.08550343841916, longitude:   140.10683178314272),
        direction: 80)
    
    static let kasugakoudou = Route(
        distination:CLLocationCoordinate2D(latitude: 36.08657352632356, longitude:   140.1058194486504),
        junction:CLLocationCoordinate2D(latitude: 36.08677996262194, longitude:   140.1060002677601),
        direction: -80)
    
    static let kasugataiikukan = Route(
        distination:CLLocationCoordinate2D(latitude: 36.08728176202757, longitude:   140.10641454954128),
        junction:CLLocationCoordinate2D(latitude: 36.08678296262194, longitude:   140.1060502677601),
        direction: 100)
    
    static let kasugatennis = Route(
        distination:CLLocationCoordinate2D(latitude: 36.087575677386646, longitude:   140.10557144800282),
        junction:CLLocationCoordinate2D(latitude: 36.08677996262194, longitude:   140.1060002677601),
        direction: 20)
    
    static let matsumibigright = Route(
        distination: CLLocationCoordinate2D(latitude:36.10691977080458, longitude: 140.10190724072956),
        junction: CLLocationCoordinate2D(latitude:36.106737742019966, longitude: 140.10206280884893),
        direction: 160)
    
    static let matsumiright = Route(
        distination: CLLocationCoordinate2D(latitude:36.10675786530117, longitude: 140.10185500828619),
        junction: CLLocationCoordinate2D(latitude:36.106737742019966, longitude: 140.10206280884893),
        direction: 100)
    
    static let matsumidiagright = Route(
        distination: CLLocationCoordinate2D(latitude:36.10657491292179, longitude: 140.1018249199128),
        junction: CLLocationCoordinate2D(latitude:36.10668139968178, longitude: 140.10206280884827),
        direction: 60)

    static let tokyoStationArea = [
        CLLocationCoordinate2D(latitude: 35.681901, longitude: 139.76861968750546),
        CLLocationCoordinate2D(latitude: 35.682405, longitude: 139.76627114508926),
        CLLocationCoordinate2D(latitude: 35.680667, longitude: 139.76587695236373),
        CLLocationCoordinate2D(latitude: 35.680037, longitude: 139.76785865385352)
    ]

    static let tokyoStationToNihonbashiStation = [
        CLLocationCoordinate2D(latitude: 35.680360872435834, longitude: 139.76895627465805),
        CLLocationCoordinate2D(latitude: 35.68356491886786, longitude: 139.77095859539386),
        CLLocationCoordinate2D(latitude: 35.68204152197238, longitude: 139.77490316724334)
    ]
    
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
            let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
            let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
            return from.distance(from: to)
        }

}
