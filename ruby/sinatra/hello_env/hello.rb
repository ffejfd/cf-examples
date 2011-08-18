require 'sinatra'

get '/' do
  e = ""
  for key in ENV.keys
    e +=  "<b>" + key + "</b>" + "=" + ENV[key] + "<br/>\n"
  end
  "<h2>I pushed this Ruby application to CloudFoundry using Ubuntu's CloudFoundry vmc!</h2><br><br>\n\n<h2>Environment</h2>\n" + e
end
