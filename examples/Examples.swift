get('username') { req in
  return "swizzlr"
}

--
var TitanApp: (Request -> Response)

private var _TitanApp = Titan()
func middleware(_) {
  _TitanApp.middleware()
}


var start: Date
var dbConn = ThreadSafePostgres()
func unsafeDB(){
  return Connections.lookupConnForThread(Thread.current) ?? UnsafePostgres()
}

middleware('*') { _ in
  start = Date()
}

middleware('*') { req in
  log(req)
  return
}

middleware('/user/*') {
  guard req['Authentication'] == "password" else {
    throw .NotAuthorized
  }
}

// Add cache control headers
middleware('*') { req in

}

get('/username') { _ in
  return "swizzlr"
}

get('*') { _ in
  return 404
}

middleware('*') { _ in
  log(Date() - start)
}

middleware() { req, res in
  req.headers['X-Translated-By'] = 'My custom middleware'
  req.body = MessagePack.decode(req.body)
  return req // res transparently inserted
}

//ForkingServer(app: TitanApp)
ThreadedServer(app: TitanApp)

--



fn(req, res) fn

get
