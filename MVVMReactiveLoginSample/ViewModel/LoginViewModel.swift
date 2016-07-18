import ReactiveKit

class LoginViewModel {
    private let disposeBag = DisposeBag()

    let loginButtonEnabled = Property<Bool>(false)

    init(user: Property<String?>, password: Property<String?>) {
        combineLatest(user, password).observeNext {[unowned self] user, password in
            self.loginButtonEnabled.value = LoginValidator.isValid(user, password: password)
        }.disposeIn(disposeBag)
    }
}