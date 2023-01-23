import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case single
    case maybe
    case completed
}

// onSuccess -> onNext + onCompleted 합친 버전
Single<String>.just("result")
    .subscribe(
        onSuccess: {print($0)},
        onFailure: {print($0)},
        onDisposed: {print("onDisposed")}
    ).disposed(by: disposeBag)

Observable<String>.create { observer -> Disposable in
    observer.onError(MyError.single)
    return Disposables.create()
}
.asSingle()
.subscribe(
    onSuccess: {print($0)},
    onFailure: {print($0.localizedDescription)},
    onDisposed: {print("disposed")}
)
.disposed(by: disposeBag)


// single -> onSuccess, onFail 두가지 이벤트 방출, 한번만 이벤트 방출하고 complete 시킴
// maybe -> onSuccess, fail, complete 세가지 이벤트, complete 은 그저 성공했음을 의미
// completable -> complete, fail 만 존재

struct MyData: Decodable {
    let name: String
}

enum JsonError: Error {
    case decodingError
}

let json1 = """
{"name": "정상훈"}
"""

let json2 = """
{name2: 박민정}
"""

func decoder(json: String) -> Single<MyData>{
    Single.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(MyData.self, from: data) else {

            print("test")
            observer(.failure(JsonError.decodingError))
            return Disposables.create()
        }

        observer(.success(json))
        return Disposables.create()
    }
}

decoder(json: json1)
    .subscribe(
        onSuccess: {print($0)},
        onFailure: {print($0.localizedDescription)},
        onDisposed: {}
    )

decoder(json: json2)
    .subscribe {
        switch $0 {
        case .success(let data):
            print(data)
        case .failure(let error):
            print(error)
        }
    }

let t = Observable.of(1,2,3,4)
