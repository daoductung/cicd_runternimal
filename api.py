from flask import Flask
from gevent.pywsgi import WSGIServer

app = Flask(__name__)
FLASK_RUN_HOST = '0.0.0.0'
FLASK_RUN_PORT = 9798


@app.route('/')
def home():
    return "Hello!"


http_server = WSGIServer((str(FLASK_RUN_HOST), int(FLASK_RUN_PORT)), app)
http_server.serve_forever()
