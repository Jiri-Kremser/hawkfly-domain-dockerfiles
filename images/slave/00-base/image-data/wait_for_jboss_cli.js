#!/usr/bin/jjs -scripting

var hostname = $ENV['DOMAIN_CONTROLLER_HOST'] || 'localhost'
var port = $ENV['DOMAIN_CONTROLLER_PORT'] || 9990

function canConnect() {
  try {
    new java.net.Socket(hostname, port)
    return true
  } catch(e) {
    return false
  }
}

while(!canConnect()) { }
