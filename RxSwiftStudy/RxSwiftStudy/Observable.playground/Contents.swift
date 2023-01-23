import UIKit
import RxSwift

let disposeBag = DisposeBag()
//
//observable 생성 방법
// just(1개만을 생성), of(여러개 생성), from(배열을 인자로 받고 하나씩 방출)
// create


Observable<Int>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onNext(2)
    observer.onCompleted()
    return Disposables.create()
}

Observable.of(1, 2, 3, 4)
    .subscribe {
        print($0)
    }

