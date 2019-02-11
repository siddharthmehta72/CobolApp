import subprocess
from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello():
    return "Hello World!"


@app.route('/<endpoint>')
def hello_endpoint(endpoint):
    output = ""
    if endpoint == 'runcobol':
        output = subprocess.check_output("/home/TESTMERGE",shell=True)
    return "endpoint called : {}!\nOutput from Cobol Code : {}".format(endpoint,output)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=3030)

