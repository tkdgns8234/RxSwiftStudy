import UIKit
import RxSwift

let disposeBag = DisposeBag()

// toArray
Observable.of(1,2,3,4)
    .toArray()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

// map
Observable.of(1,2,3,4,5)
    .map( {
        "\($0 + 4)" + "a"
    })
    .subscribe {
        print($0)
    }

//flatMap
// observable 이 겹쳐진 경우 사용 가능
// 겹쳐진 경우 하위 observable의 onNext 이벤트도 모두 받는다
//flatMapLatest -> map + switchLatest: 이전 옵저버블을 구독 해제함
// 하나의 옵저버블에서 두개의 옵저버블을 구독중일때 마지막 옵저버블에대한 시퀀스 값만 방출됨

//materialize -> 이벤트로 감싼다 dematerialize -> 다시 풀어쓴다

print("--------flatMap--------")
protocol 선수 {
    var 점수: BehaviorSubject<Int> { get }
}

struct 양궁선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 🇰🇷국가대표 = 양궁선수(점수: BehaviorSubject(value: 10))
let 🇺🇸국가대표 = 양궁선수(점수: BehaviorSubject(value: 8))

let 올림픽경기 = PublishSubject<선수>()

올림픽경기
    .flatMap {
        $0.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

올림픽경기.onNext(🇰🇷국가대표)
🇰🇷국가대표.점수.onNext(10)

올림픽경기.onNext(🇺🇸국가대표)
🇰🇷국가대표.점수.onNext(10)
🇺🇸국가대표.점수.onNext(9)

print("--------flatMapLatest--------")
struct 높이뛰기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 서울 = 높이뛰기선수(점수: BehaviorSubject(value: 7))
let 제주 = 높이뛰기선수(점수: BehaviorSubject(value: 6))

let 전국체전 = PublishSubject<선수>()

전국체전
    .flatMapLatest {
        $0.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

전국체전.onNext(서울)
서울.점수.onNext(9)

전국체전.onNext(제주)
서울.점수.onNext(10)
제주.점수.onNext(8)

print("--------materialize and dematerialize--------")
enum 반칙: Error {
    case 부정출발
}

struct 달리기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 김토끼 = 달리기선수(점수: BehaviorSubject(value: 0))
let 박치타 = 달리기선수(점수: BehaviorSubject(value: 1))

let 달리기100M = BehaviorSubject<선수>(value: 김토끼)

달리기100M
    .flatMapLatest {
        $0.점수
//            .materialize()    // 1) materialize 추가
    }
    /* 2) demeterialize 추가
    .filter {
        guard let error = $0.error else {
            return true
        }
        print(error)
        return false
    }
    .dematerialize()
    */
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

김토끼.점수.onNext(1)
김토끼.점수.onError(반칙.부정출발)
김토끼.점수.onNext(2)

달리기100M.onNext(박치타)

print("--------전화번호 11자리--------")
let input = PublishSubject<Int?>()

let list: [Int] = [1]
input
    .flatMap {
        $0 == nil ? Observable.empty() : Observable.just($0)
    }
    .map { $0! }
    .skip(while: { $0 != 0 })
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map { "\($0)" }
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(4)
input.onNext(3)
input.onNext(nil)
input.onNext(1)
input.onNext(8)
input.onNext(9)
input.onNext(4)
input.onNext(9)
input.onNext(4)
