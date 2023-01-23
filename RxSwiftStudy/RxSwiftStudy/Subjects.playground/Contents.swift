import UIKit
import RxSwift


// Subject -> observable과 observer 가 합쳐진 형태
// publishSubject -> 새로운 값 만을 구독자에게 방출
// behaviorsubject -> 가장 최신 값 + 새로운 값을 구독자에게 방출, 기본값 필요
// replaysubject -> 버퍼를 가지며 구독 이전의 버퍼만큼의 값을 방출

let disposeBag = DisposeBag()

let publishSubject = PublishSubject<String>()

publishSubject.onNext("안녕하세요")

let 구독자1 = publishSubject.subscribe(
    onNext: {
        print($0)
    }
).disposed(by: disposeBag)

publishSubject.onNext("1")
publishSubject.onNext("2")
publishSubject.onCompleted()
publishSubject.onNext("3")




let behaviorSubject = BehaviorSubject<String>(value: "초깃값")

behaviorSubject.onNext("1")
behaviorSubject.subscribe {
    print($0)
}.disposed(by: disposeBag)

behaviorSubject.onNext("2")
behaviorSubject.onNext("3")

// behavior 에서만 value 를 뽑아낼 수 있음
let val = try? behaviorSubject.value()
print(val)


let replaySubject = ReplaySubject<Int>.create(bufferSize: 3)

replaySubject.onNext(1)
replaySubject.onNext(2)
replaySubject.onNext(3)
replaySubject.onNext(4)

replaySubject.subscribe {
    print($0.element)
}.disposed(by: disposeBag)

