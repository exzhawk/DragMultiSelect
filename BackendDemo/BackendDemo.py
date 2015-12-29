import json
import os
import re
import urllib
from cStringIO import StringIO

from PIL import Image
from flask import Flask, request, send_from_directory, send_file
from send2trash import send2trash

app = Flask(__name__)
file_filter = re.compile(r'.*\.(jpg|png|gif|jpeg|bmp)', re.IGNORECASE)
size = 298, 298
cache_dir = r"H:\TEMP\pic_cache"


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
    cache_path = os.path.join(cache_dir, urllib.quote(path.encode('utf8')))
    if os.path.isfile(cache_path):
        return send_file(cache_path, mimetype="image/jpg")
    else:
        if file_filter.match(path):
            f = StringIO()
            im = Image.open(path)
            im.thumbnail(size, Image.BILINEAR)
            im.save(f, "JPEG")
            f.seek(0)
            return send_file(f, mimetype="image/jpg")
        else:
            return send_file(path)


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
