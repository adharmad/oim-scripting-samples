from java.util import *

def map2hm(map):
    hm = HashMap()
    for k in map.iterkeys():
        hm.put(k, map[k])

    return hm
