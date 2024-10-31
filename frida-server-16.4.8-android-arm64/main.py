import time
import frida
import sys
import os
import codecs
import binascii
import base64

def savefile(path, data):
    print(path)
    if not os.path.exists(os.path.dirname(path)):
        try:
            os.makedirs(os.path.dirname(path))
        except OSError as exc:  # Guard against race condition
            raise
    with codecs.open(path, 'wb') as f:
        f.write(data)

def on_message(message, data):
    if 'payload' in message and message['type'] == 'send':
        print(f'message: {message}')
        payload = message['payload']
        origin_path = payload['path']
        # if 'dump' in payload:
            # dump = payload['dump']
            # # hexedDump = ":".join("{:02x}".format(ord(c)) for c in dump)
            # # print(f'dump: {dump}')
            # # print(f'hexedDump: {hexedDump}')
            # savefile(origin_path,dump.encode('utf-8'))
            # return
        if message['type'] == 'send':
            print(f'data: {data[:100]}')
            savefile(origin_path, data)
        else:
            print(f'message: {message}')

device = frida.get_usb_device()
pid = 'Gadget'
device.resume(pid)
time.sleep(1)
session = device.attach(pid)
with open("dumpPng.js") as f:
# with open("dumpSpine.js") as f:
    script = session.create_script(f.read())
script.on("message", on_message)
script.load()
sys.stdin.read()