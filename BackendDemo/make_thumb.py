# -*- encoding: utf-8 -*-
# Author: Epix
import codecs
import os
import time
from collections import Counter
from multiprocessing import Pool
from urllib import quote

from PIL import Image

from BackendDemo import file_filter, size, cache_dir


def get_files():
    with codecs.open('dirs.txt', 'r', 'utf8') as dirs:
        for d in dirs:
            d = d.strip()
            for f in os.listdir(d):
                if file_filter.match(f):
                    fi_path = os.path.join(d, f).encode('utf8')
                    yield fi_path


def make_thumb(fi_path):
    fo_path = os.path.join(cache_dir, quote(fi_path, safe=''))
    if os.path.isfile(fo_path):
        return 2
    else:
        try:
            im = Image.open(fi_path)
            im.thumbnail(size)
            im.save(fo_path)
            return 0
        except:
            print(fi_path)
            return 1


if __name__ == '__main__':
    start_time = time.time()
    pool = Pool(4)
    result = pool.map(make_thumb, get_files())
    pool.close()
    pool.join()
    end_time = time.time()
    r = Counter(result)
    print("success:%s\tfail:%s\tskip:%s\ttime:%s" % (r.get(0, 0), r.get(1, 0), r.get(2, 0), end_time - start_time))
