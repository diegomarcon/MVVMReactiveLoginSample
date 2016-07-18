module.exports = function (context, done) {
  var user = context.data.user;
  var password = context.data.password;

  if (user != 'testuser') done(null, { error: 'User not registered' })
  if (password != '1234') done(null, { error: 'Wrong password' })

  done(null, { token: 'Success Token'})
}
