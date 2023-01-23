import UIKit
import RxSwift

// filtering operator


let disposeBag = DisposeBag()

// ignorElements -> complete, error 등은 허용, onNext 는 무시
//let ps = PublishSubject<Int>()
//
//ps
//    .ignoreElements()
//    .subscribe {
//        print($0)
//    }
//    .disposed(by: disposeBag)
//
//ps.onNext(1)
//ps.onNext(2)
//ps.onCompleted()
//
//// elementAt 해당하는 인덱스 위치에 대한 이벤트만 방출
//
//let ps2 = PublishSubject<Int>()
//
//ps2
//    .element(at: 2)
//    .subscribe {
//        print($0)
//    }
//    .disposed(by: disposeBag)
//
//ps2.onNext(1)
//ps2.onNext(2)
//ps2.onNext(3)

//filter

//let ps3 = PublishSubject<Int>()
//
//ps3
//    .filter {$0 % 2 == 0}
//    .subscribe {
//        print($0)
//    }
//    .disposed(by: disposeBag)
//
//ps3.onNext(1)
//ps3.onNext(2)
//ps3.onNext(3)

// skip

//let test = Observable.of(1, 2, 3, 4, 5)
//let test2 = PublishSubject<Int>()
//let test3 = PublishSubject<Int>()
//
//test
//    .skip(4)
//    .subscribe {
//        print($0)
//    }
//
//test
//    .skip(while: {
//        $0 != 3
//    })
//    .subscribe {
//        print($0)
//    }
//
//test2.onNext(1)
//
//test2
//    .skip(until: test3) // 다른 옵저버블이 시도할때까지 skip
//    .subscribe {
//        print($0)
//    }
//
//test2.onNext(2)
//test2.onNext(3)
//test3.onNext(1)
//test2.onNext(5)

// take 해당 갯수만큼만 방출
//Observable.of(1,2,3,4,5)
//    .take(3)
//    .subscribe {
//        print($0)
//    }
//
//Observable.of(1,2,3,4,5)
//    .take(while: {
//        $0 != 3
//    })
//    .subscribe {
//        print($0)
//    }


// enumerated 인덱스를 같이 사용할 때
//Observable.of("a","b","3","4")
//    .enumerated()
//    .take(while: {
//        $0.index < 2
//    })
//    .subscribe {
//        print($0)
//    }

// distinctUntilChanged 동일한 요소 skip
Observable.of(1,1,1,1,2,2,2,2,3,3,3,3,4,5,6)
    .distinctUntilChanged()
    .subscribe {
        print($0)
    }
