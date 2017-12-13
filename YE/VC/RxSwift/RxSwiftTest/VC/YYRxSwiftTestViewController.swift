//
//  YYRxSwiftTestViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import RxSwift

class YYRxSwiftTestViewController: YYBaseViewController {
    
    var type: rxType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        rxSwift()
    }
    
    func rxSwift() {
        switch type {
        case .of:
            of()
        case .generate:
            generate()
        case .error:
            error()
        case .deferred:
            deferred()
        case .empty:
            empty()
        case .never:
            never()
        case .just:
            just()
        case .publishSubject:
            publishSubject()
        case .replaySubject:
            replaySubject()
        case .behaviorSubject:
            behaviorSubject()
        case .variable:
            variable()
        case .map:
            map()
        case .flatMap:
            flatMap()
        case .scan:
            scan()
        case .distinctUntilChanged:
            distinctUntilChanged()
        case .take:
            take()
        case .startWith:
            startWith()
        case .combineLatest:
            combineLatest()
        case .zip:
            zip()
        case .merge:
            merge()
        case .switchLatest:
            switchLatest()
        case .catchError:
            catchError()
        case .retry:
            retry()
        case .subscribe:
            subscribe()
        case .subscribeNext:
            subscribeNext()
        case .subscribeCompleted:
            subscribeCompleted()
        case .subscribeError:
            subscribeError()
        case .doOn:
            doOn()
        case .takeUntil:
            takeUntil()
        case .takeWhile:
            takeWhile()
        case .concat:
            concat()
        case .reduce:
            reduce()
        case .delay:
            delay()
        case .none:
            break
        case .some(_):
            break
        }
    }
    /* 打印结果
     
     */
    /* 说明
     // 怎么结束？
     */
    func delay() {
        let observer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        _ = observer.subscribe() {
            print($0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            _ = observer.subscribe() {
                print("延迟5秒 -- $0")
            }
        }
    }
    /* 打印结果
     next(49)
     completed
     */
    /* 说明
     Applies an `accumulator` function over an observable sequence, returning the result of the aggregation as a single element in the result sequence. The specified `seed` value is used as the initial accumulator value.
     */
    func reduce() {
        _ = Observable.of(1, 2, 3, 4, 5, 6, 6, 6, 7, 8)
            .reduce(1, accumulator: +)
            .subscribe() {
                print($0)
        }
    }
    /* 打印结果
     next(0)
     next(1)
     next(2)
     next(3)
     next(4)
     next(5)
     */
    /* 说明
     Concatenates the second observable sequence to `self` upon successful termination of `self`.
     */
    func concat() {
        let subject1 = BehaviorSubject(value: 0)
        let subject2 = BehaviorSubject(value: 666)
        let subject3 = BehaviorSubject(value: subject1)
        
        _ = subject3.concat().subscribe() {
            print($0)
        }
        
        subject1.onNext(1)
        subject1.onNext(2)
        subject1.onNext(3)
        subject3.onNext(subject2)
        subject2.onNext(777)
        subject2.onNext(888)
        subject1.onNext(4)
        subject1.onNext(5)
        subject2.onNext(999)
    }
    /* 打印结果
     next(1)
     next(2)
     next(3)
     completed
     */
    /* 说明
     Returns elements from an observable sequence as long as a specified condition is true.
     */
    func takeWhile() {
        let subject = PublishSubject<Int>()
        _ = subject.takeWhile({ (event) -> Bool in
            return event < 4
        }).subscribe() {
            print($0)
        }
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        subject.onNext(4)
        subject.onNext(5)
    }
    /* 打印结果
     next(1)
     next(2)
     next(3)
     next(4)
     completed
     */
    /* 说明
     Returns the elements from the source observable sequence until the other observable sequence produces an element.
     */
    func takeUntil() {
        let subject = PublishSubject<Int>()
        let stopSubject = PublishSubject<Int>()
        _ = subject.takeUntil(stopSubject).subscribe() {
            print($0)
        }
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        subject.onNext(4)
        stopSubject.onNext(101)
        subject.onNext(5)
        subject.onNext(6)
    }
    /* 打印结果
     1
     next(1)
     
     completed
     */
    /* 说明
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - parameter onError: Action to invoke upon errored termination of the observable sequence.
     - parameter onCompleted: Action to invoke upon graceful termination of the observable sequence.
     - parameter onDisposed: Action to invoke upon any type of termination of sequence (if the sequence has
     */
    func doOn() {
        let subject = PublishSubject<Int>()
        _ = subject.do(onNext: {
            print($0)
        }, onError: nil, onCompleted: {
            print()
        }).subscribe {
            print($0)
        }
        subject.onNext(1)
        subject.onCompleted()
    }
    /* 打印结果
     
     */
    /* 说明
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - parameter onError: Action to invoke upon errored termination of the observable sequence.
     - parameter onCompleted: Action to invoke upon graceful termination of the observable sequence.
     - parameter onDisposed: Action to invoke upon any type of termination of sequence (if the sequence has
     */
    func subscribeError() {
        let subject = PublishSubject<Int>()
        _ = subject.subscribe(onError: { (error) in
            print(error)
        })
        subject.onNext(1)
        let error = NSError(domain: "Test", code: -2, userInfo: nil)
        subject.onError(error)
    }
    /* 打印结果
     
     */
    /* 说明
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - parameter onError: Action to invoke upon errored termination of the observable sequence.
     - parameter onCompleted: Action to invoke upon graceful termination of the observable sequence.
     - parameter onDisposed: Action to invoke upon any type of termination of sequence (if the sequence has
     */
    func subscribeCompleted() {
        let subject = PublishSubject<Int>()
        _ = subject.subscribe(onCompleted: {
            print("已经完成了")
        })
        subject.onNext(1)
        subject.onCompleted()
    }
    /* 打印结果
     
     */
    /* 说明
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - parameter onError: Action to invoke upon errored termination of the observable sequence.
     - parameter onCompleted: Action to invoke upon graceful termination of the observable sequence.
     - parameter onDisposed: Action to invoke upon any type of termination of sequence (if the sequence has
     */
    func subscribeNext() {
        let subject = PublishSubject<Int>()
        _ = subject.subscribe(onNext: {
            print($0)
        })
        subject.onNext(1)
        subject.onCompleted()
    }
    /* 打印结果
     next(1)
     completed
     */
    /* 说明
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - parameter onError: Action to invoke upon errored termination of the observable sequence.
     - parameter onCompleted: Action to invoke upon graceful termination of the observable sequence.
     - parameter onDisposed: Action to invoke upon any type of termination of sequence (if the sequence has
     */
    func subscribe() {
        let subject = PublishSubject<Int>()
        _ = subject.subscribe() {
            print($0)
        }
        subject.onNext(1)
        subject.onCompleted()
    }
    /* 打印结果
     next(0)
     next(1)
     next(2)
     next(0)
     next(1)
     next(2)
     next(3)
     next(4)
     next(5)
     completed
     */
    /* 说明
     Repeats the source observable sequence until it successfully terminates.
     */
    func retry() {
        var count = 1
        let subject = Observable<Int>.create { observer in
            let error = NSError(domain: "Test", code: 0, userInfo: nil)
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            if (count < 2) {
                observer.onError(error)
                count += 1
            }
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onCompleted()
            return Disposables.create()
        }
        _ = subject.retry()
            .subscribe() {
                print($0)
        }
        
    }
    /* 打印结果
     next(1)
     next(1)
     next(2)
     next(2)
     next(3)
     next(3)
     next(4)
     next(4)
     next(100)
     next(200)
     next(300)
     next(400)
     completed
     next(110)
     completed
     */
    /* 说明
     * catchError
     Continues an observable sequence that is terminated by an error with the observable sequence produced by the handler.
     * catchErrorJustReturn
     Continues an observable sequence that is terminated by an error with a single element.
     */
    func catchError() {
        let subject = PublishSubject<Int>()
        let errorObservable = Observable.of(100, 200, 300, 400)
        _ = subject.catchError {
            error in
            return errorObservable
            }.subscribe() {
                print($0)
        }
        
        _ = subject.catchErrorJustReturn(110)
            .subscribe() {
                print($0)
        }
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        subject.onNext(4)
        subject.onError(NSError(domain: "Test", code: 0, userInfo: nil))
    }
    /* 打印结果
     next(0)
     next(1)
     next(2)
     next(3)
     next(200)
     next(201)
     completed
     */
    /* 说明
     Transforms an observable sequence of observable sequences into an observable sequence
     producing values only from the most recent observable sequence.
     */
    func switchLatest() {
        let var1 = Variable(0)
        let var2 = Variable(200)
        let var3 = Variable(var1.asObservable())
        
        _ = var3
            .asObservable()
            .switchLatest()
            .subscribe() {
                print($0)
        }
        var1.value = 1
        var1.value = 2
        var1.value = 3
        var3.value = var2.asObservable()
        var2.value = 201
        var1.value = 4
        var1.value = 5
        var1.value = 6
    }
    /* 打印结果
     next(2)
     next(4)
     next(1)
     next(6)
     next(7)
     */
    /* 说明
     Merges elements from all inner observable sequences into a single observable sequence, limiting the number of concurrent subscriptions to inner sequences.
     */
    func merge() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        _ = Observable.of(subject1, subject2)
            .merge(maxConcurrent: 2)
            .subscribe() {
                print($0)
        }
        
        subject2.onNext(2)
        subject1.onNext(4)
        subject1.onNext(1)
        subject2.onNext(6)
        subject2.onNext(7)
    }
    /* 打印结果
     next(iOS10)
     next(swift4)
     */
    /* 说明
     Merges the specified observable sequences into one observable sequence by using the selector function whenever all of the observable sequences have produced an element at a corresponding index.
     */
    func zip() {
        let stringObserver = PublishSubject<String>()
        let intObserver = PublishSubject<Int>()
        _ = Observable.zip(stringObserver, intObserver) {
            "\($0)\($1)"
            }.subscribe {
                print($0)
        }
        
        stringObserver.onNext("iOS")
        intObserver.onNext(10)
        
        stringObserver.onNext("swift")
        intObserver.onNext(4)
        
        stringObserver.onNext("不打印")
    }
    
    /* 打印结果
     next(我 and 你)
     next(swift and 你)
     next(swift and oc)
     next(rx and oc)
     next(666 and oc)
     */
    /* 说明
     Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.
     */
    func combineLatest() {
        let observer1 = PublishSubject<String>()
        let observer2 = PublishSubject<String>()
        _ = Observable.combineLatest(observer1, observer2) {
            "\($0) and \($1)"
            }.subscribe() {
                print($0)
        }
        observer1.onNext("我")
        observer2.onNext("你")
        
        observer1.onNext("swift")
        observer2.onNext("oc")
        
        observer1.onNext("rx")
        observer1.onNext("666")
    }
    /* 打印结果
     next(101)
     next(1)
     next(2)
     next(3)
     completed
     */
    /* 说明
     Prepends a sequence of values to an observable sequence.
     */
    func startWith() {
        _ = Observable.of(1, 2, 3).startWith(101).subscribe {
            print($0)
        }
    }
    /* 打印结果
     next(1)
     next(2)
     next(3)
     completed
     */
    /* 说明
     Returns a specified number of contiguous elements from the start of an observable sequence.
     */
    func take() {
        _ = Observable.of(1, 2, 3, 4, 5, 6, 6)
            .take(3)
            .subscribe() {
                print($0)
        }
    }
    /* 打印结果
     next(1)
     next(2)
     next(3)
     next(4)
     completed
     */
    /* 说明
     Returns an observable sequence that contains only distinct contiguous elements according to equality operator.
     */
    func distinctUntilChanged() {
        _ = Observable.of(1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4).distinctUntilChanged().subscribe() {
            print($0)
        }
    }
    /* 打印结果
     next(3)
     next(5)
     next(8)
     next(12)
     completed
     */
    /* 说明
     Applies an accumulator function over an observable sequence and returns each intermediate result. The specified seed value is used as the initial accumulator value.
     */
    func scan() {
        let scan = Observable.of(1, 2, 3, 4)
        _ = scan.scan(2, accumulator: { (acum, elem) -> Int in
            acum + elem
        }).subscribe() {
            print($0)
        }
    }
    /* 打印结果
     10
     next(a)
     1
     next(b)
     next(a)
     2
     next(c)
     next(b)
     next(a)
     3
     next(d)
     next(c)
     next(b)
     next(a)
     4
     next(iOS)
     next(d)
     next(c)
     next(b)
     next(a)
     next(iOS)
     next(d)
     next(c)
     next(b)
     next(iOS)
     next(d)
     next(c)
     next(iOS)
     next(d)
     next(iOS)
     completed
     */
    /* 说明
     Projects each element of an observable sequence to an observable sequence and merges the resulting observable sequences into one observable sequence.
     */
    func flatMap() {
        let flatMap = Observable.of(10, 1, 2, 3, 4)
        let string = Observable.of("a", "b", "c", "d", "iOS")
        _ = flatMap.flatMap({ (event) -> Observable<String> in
            print(event)
            return string
        }).subscribe {
            print($0)
        }
        
        let ss = string.flatMap({ (event) -> Observable<String> in
            print(event)
            return string
        }).subscribe {
            print($0)
        }
        print(ss) // RxSwift.(SinkDisposer in _B4E79ED897163AA84B94CE0A507A4630)
    }
    /* 打印结果
     next(2)
     next(4)
     next(6)
     completed
     */
    /* 说明
     Projects each element of an observable sequence into a new form.
     */
    func map() {
        let map = Observable.of(1, 2, 3)
        _ = map.map({
            $0 * 2
        }).subscribe {
            print($0)
        }
    }
    /* 打印结果
     1、 next(z)
     1、 next(a)
     1、 next(b)
     2、 next(b)
     1、 next(c)
     2、 next(c)
     1、 completed
     2、 completed
     */
    /* 说明
     /// Variable is a wrapper for `BehaviorSubject`.
     ///
     /// Unlike `BehaviorSubject` it can't terminate with error, and when variable is deallocated
     /// it will complete its observable sequence (`asObservable`).
     */
    func variable() {
        let variable = Variable("z")
        _ = variable.asObservable().subscribe {
            print("1、", $0)
        }
        variable.value = "a"
        variable.value = "b"
        _ = variable.asObservable().subscribe {
            print("2、", $0)
        }
        variable.value = "c"
    }
    
    /* 打印结果
     1、 next(z)
     1、 next(a)
     1、 next(b)
     2、 next(b)
     1、 next(c)
     2、 next(c)
     1、 completed
     2、 completed
     */
    /* 说明
     Observers can subscribe to the subject to receive the last (or initial) value and all subsequent notifications.
     */
    func behaviorSubject() {
        let behaviorSubject = BehaviorSubject(value: "z")
        _ = behaviorSubject.subscribe {
            print("1、", $0)
        }
        behaviorSubject.onNext("a")
        behaviorSubject.onNext("b")
        
        _ = behaviorSubject.subscribe {
            print("2、", $0)
        }
        
        behaviorSubject.onNext("c")
        behaviorSubject.onCompleted()
    }
    /* 打印结果
     1、 next(3)
     2、 next(3)
     1、 next(4)
     2、 next(4)
     */
    /* 说明
     /// Each notification is broadcasted to all subscribed and future observers, subject to buffer trimming policies.
     */
    func replaySubject() {
        let replaySubject = ReplaySubject<Int>.create(bufferSize: 2)
        _ = replaySubject.subscribe {
            print("1、", $0)
        }
        _ = replaySubject.subscribe {
            print("2、", $0)
        }
        replaySubject.onNext(3)
        replaySubject.onNext(4)
    }
    /* 打印结果
     next(0)
     next(101)
     next(11011)
     */
    /* 说明
     /// Each notification is broadcasted to all subscribed observers.
     */
    func publishSubject() {
        let publishSubject = PublishSubject<Int>()
        _ = publishSubject.subscribe {
            print($0)
        }
        publishSubject.onNext(0)
        publishSubject.onNext(101)
        publishSubject.onNext(11011)
    }
    /* 打印结果
     next(大帅帅)
     completed
     */
    /* 说明
     Returns an observable sequence that contains a single element.
     */
    func just() {
        let just = Observable.just("大帅帅")
        _ = just.subscribe {
            print($0)
        }
    }
    /* 打印结果
     
     */
    /* 说明
     Returns a non-terminating observable sequence, which can be used to denote an infinite duration.
     */
    func never() {
        let never = Observable<Int>.never()
        _ = never.subscribe{
            print("打印这句吗？")
        }
    }
    /* 打印结果
     completed
     */
    /* 说明
     Returns an empty observable sequence, using the specified scheduler to send out the single `Completed` message.
     */
    func empty() {
        let empty = Observable<Int>.empty()
        _ = empty.subscribe({ (event) in
            print(event)
        })
    }
    /* 打印结果
     creating
     emmiting
     next(0)
     next(1)
     next(2)
     creating
     emmiting
     next(0)
     next(1)
     next(2)
     */
    /* 说明
     deferred
     Returns an observable sequence that invokes the specified factory function whenever a new observer subscribes.
     */
    func deferred() {
        let deferred: Observable<Int> = Observable.deferred {
            print("creating")
            return Observable.create({ (observer) -> Disposable in
                print("emmiting")
                observer.onNext(0)
                observer.onNext(1)
                observer.onNext(2)
                return Disposables.create()
            })
        }
        _ = deferred.subscribe({ (event) in
            print(event)
        })
        _ = deferred.subscribe({ (event) in
            print(event)
        })
    }
    /* 打印结果
     --
     */
    /* 说明
     Returns an observable sequence that terminates with an `error`.
     */
    func error() {
        let error = NSError(domain: "test", code: -1, userInfo: nil)
        let erroredSequence = Observable<Any>.error(error)
        _ = erroredSequence.subscribe({ (event) in
            print(event.element ?? "--")
        })
    }
    /* 打印结果
     0
     4
     8
     12
     16
     */
    /* 说明
     Generates an observable sequence by running a state-driven loop producing the sequence's elements, using the specified scheduler
     to run the loop send out observer messages.
     */
    func generate() {
        let generated = Observable.generate(initialState: 0, condition: {
            $0<20
        }) {
            $0+4
        }
        _ = generated.subscribe({ (envent) in
            print(envent.element ?? "")
        })
    }
    
    /* 打印结果
     1
     2
     3
     */
    /* 说明
     Sequence: 序列事件
     of: This method creates a new Observable instance with a variable number of elements.
     */
    func of() {
        let sequenceOfElements = Observable.of("1", "2", "3")
        _ = sequenceOfElements.subscribe({ event in
            print(event.element ?? "")
        })
    }
}

