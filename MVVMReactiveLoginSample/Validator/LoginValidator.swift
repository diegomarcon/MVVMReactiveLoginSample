class LoginValidator {
    class func isValid(user: String?, password: String?) -> Bool {
        guard let user = user, let password = password else {
            return false
        }

        return !user.isEmpty && !password.isEmpty
    }
}