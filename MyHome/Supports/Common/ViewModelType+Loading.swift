extension ViewModelType {
    
    func setupLoading<T>(loadTrigger: Driver<Void>,
                         getItem: @escaping () -> Observable<T>,
                         refreshTrigger: Driver<Void>,
                         refreshItem: @escaping () -> Observable<T>)
        -> (item: Driver<T>,
        error: Driver<Error>,
        loading: Driver<Bool>,
        refreshing: Driver<Bool>) {

            let errorTracker = ErrorTracker()
            let loadingActivityIndicator = ActivityIndicator()
            let refreshingActivityIndicator = ActivityIndicator()

            let loading = loadingActivityIndicator.asDriver()
            let refreshing = refreshingActivityIndicator.asDriver()

            let loadingOrRefreshing = Driver.merge(loading, refreshing)
                .startWith(false)

            let loadItem = loadTrigger
                .withLatestFrom(loadingOrRefreshing)
                .filter { !$0 }
                .flatMapLatest { _ in
                    getItem()
                        .trackError(errorTracker)
                        .trackActivity(loadingActivityIndicator)
                        .asDriverOnErrorJustComplete()
                }

            let refreshItem = refreshTrigger
                .withLatestFrom(loadingOrRefreshing)
                .filter { !$0 }
                .flatMapLatest { _ in
                    refreshItem()
                        .trackError(errorTracker)
                        .trackActivity(refreshingActivityIndicator)
                        .asDriverOnErrorJustComplete()
                }

            let item = Driver.merge(loadItem, refreshItem)

            return (item,
                    errorTracker.asDriver(),
                    loading,
                    refreshing)
    }
}
