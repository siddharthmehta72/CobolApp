import subprocess
from flask import Flask
from flask import request

app = Flask(__name__)


@app.route('/')
def hello():
    return "Hello World!"


@app.route('/runcobol', methods=['GET', 'POST'])
def hello_endpoint():
    file1 = request.args.get('f1')
    file2 = request.args.get('f2')
    file3 = request.args.get('merge')
    output = subprocess.check_output("/home/TESTMERGE /data/" + file1 + " /data/" + file2 + " /data/" + file3 ,shell=True)
    return "Output from Cobol Code : {}".format(output)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8090)
