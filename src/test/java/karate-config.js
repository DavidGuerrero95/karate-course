function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'guerrero16.395@gmail.com'
    config.userPassword = 'santiago95'
  } else if (env == 'qa') {
    config.userEmail = 'guerrero216.395@gmail.com'
    config.userPassword = 'santiago952'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers',{Authorization: 'Token ' + accessToken})

  return config;
}