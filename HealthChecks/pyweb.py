# Python 3 server example
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path
from random import randint
import time,os

hostName = "0.0.0.0"
serverPort = 8080

class MyServer(BaseHTTPRequestHandler):
    def do_GET(self):
        if os.path.exists('/tmp/ok'):
            time.sleep(randint(100,1000)/1000)  # Time your app takes to respond
            self.send_response(200)
        else:
            self.send_response(500)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(bytes("<html><head><title>https://pythonbasics.org</title></head>", "utf-8"))
        self.wfile.write(bytes("<p>Request: %s</p>" % self.path, "utf-8"))
        self.wfile.write(bytes("<body>", "utf-8"))
        self.wfile.write(bytes("<p>This is an example web server.</p>", "utf-8"))
        self.wfile.write(bytes("</body></html>", "utf-8"))

if __name__ == "__main__":        
    Path('/tmp/ok').touch()
    if os.getenv('DELAY') is not None:
        time.sleep(int(os.getenv('DELAY')))
    webServer = HTTPServer((hostName, serverPort), MyServer)
    print("Server started http://%s:%s" % (hostName, serverPort))
    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")
