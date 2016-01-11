import json
import os
import urllib

from flask import Flask, request, send_from_directory, send_file
from send2trash import send2trash

from make_thumb import file_filter, cache_dir, make_thumb

app = Flask(__name__)


@app.route('/browse', methods=['GET'])
def browse_file():
    path = request.args.get('path')
    files = []
    for f in os.listdir(path):
        if file_filter.match(f):
            files.append(os.path.join(path, f))
    return json.dumps(files)


@app.route('/file', methods=['GET'])
def get_file():
    path = request.args.get('path')
    thumb_result = make_thumb(path)
    if thumb_result is 1:
        return send_file(path)
    else:
        cache_path = os.path.join(cache_dir, urllib.quote(path.encode('utf8')))
        return send_file(cache_path)


@app.route('/delete', methods=['POST'])
def delete_file():
    file_list = request.form.getlist('paths[]')
    for f in file_list:
        try:
            send2trash(f)
        except:
            print("ERROR %s" % f)
    return "deleted"


@app.route('/')
def index_page():
    return send_file(app.root_path + "\\..\\demo\\demo.html")


@app.route('/favicon.ico')
def favicon():
    return send_file(app.root_path + "\\..\\demo\\favicon.ico")


@app.route('/<path:path>')
def static_html(path):
    if path.startswith('js'):
        return send_from_directory(app.root_path + '\\..\\', path)
    else:
        return send_from_directory(app.root_path + '\\..\\demo', path)


if __name__ == '__main__':
    app.run(
            # debug=True
    )
