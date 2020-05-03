import codecs
import os
import pathlib
from datetime import datetime

def actions(str action_list):
    cdef list actions = []
    for log in action_list:
        if datetime.utcfromtimestamp(log.created_utc).month == datetime.now().month:
            actions.append(log.action)
        else:
            break
    return actions

def info():
    cdef list python_files = []
    cdef list cpp_files = []
    cdef int total = 0
    for path, subdirs, files in os.walk(r'..'):
        for name in files:
            if name.endswith('.py'):
                python_files.append(name)
            if name.endswith('.cpp'):
                cpp_files.append(name)
                with codecs.open(str(pathlib.PurePath(path, name)),
                                 'r', 'utf-8') as f:
                    print(str(pathlib.PurePath(path, name)))
                    for i, l in enumerate(f):
                        if name.endswith('.py'):
                            print(name)
                        if len(l.strip()) != 0 and name.endswith('.py') or name.endswith('.cpp') or name.endswith(
                                '.c'):
                            total += 1
    return python_files, cpp_files, total
