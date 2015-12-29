# -*- encoding: utf-8 -*-
# Author: Epix
import codecs
import os
from urllib import quote

from PIL import Image

from BackendDemo import file_filter, size, cache_dir

with codecs.open('dirs.txt', 'r', 'utf8') as dirs:
    for d in dirs:
        d = d.strip()
        for f in os.listdir(d):
            if file_filter.match(f):
                fi_path = os.path.join(d, f).encode('utf8')
                fo_path = os.path.join(cache_dir, quote(fi_path, safe=''))
                try:
                    im = Image.open(fi_path)
                    im.thumbnail(size)
                    im.save(fo_path, "JPEG")
                except:
                    print(fi_path)
