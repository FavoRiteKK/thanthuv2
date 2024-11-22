var nptr1;
var nptr2;
var xxteaDecryptPtr;
let worker = new Map();

function fn() {
    nptr1 = Module.findExportByName('libcocos2dluar.so', "_ZNK7cocos2d9FileUtils49lua_cocos2dx_ui_Widget_getWorldPosition__VerticalEPNS_15ResizableBufferE");
	xxteaDecryptPtr = Module.findExportByName('libcocos2dluar.so', "_Z16tj_xxtea_decryptPhjS_jPj");
    nptr2 = Module.findExportByName('libcocos2dluar.so', "LZ4_decompress_safe");
    if (!nptr1 || !nptr2 || !xxteaDecryptPtr) {
        console.log("AAsset_read cannot be found!");
        setTimeout(foo, 500);
    } else {
        console.log("AAsset_read found!");
        
		Interceptor.attach(nptr1, {
            onEnter: function(args) {
                console.log('$ getWorldPosition: ' + this.threadId);
                this.w = args[2];
                const fileName = this.w.readCString();
                console.log('$ fileName: "' + fileName + '" @' + this.threadId);
                worker.set(this.threadId, fileName);
            },
            onLeave: function(retval) {
                try {
                    worker.delete(this.threadId);
                    // console.log('	retval: "' + retval + '"');
                } catch (err) {
                    console.log('err: ' + err);
                }
                // console.log('leave getWorldPosition():');
            }
        });
		
		Interceptor.attach(xxteaDecryptPtr, {
            onEnter: function(args) {
                // console.log('$ tj_xxtea_decrypt:' + this.threadId);
                this.u = args[4];
            },
            onLeave: function(retval) {
                try {
                    const tid = this.threadId;
                    const fileName = worker.get(tid);

                    if (fileName.endsWith('.png')) {
                        var code = retval.readByteArray(this.u.readInt()); // file content
                        // console.log('code: ' + code);
                        send({ path: "/home/khiemnv3/Downloads/LamGame/ThanThuRef_as_prj/frameworks/thanthuv2/frida-server-16.4.8-android-arm64/" + fileName, dump: tid  }, code);

                        const op = recv(tid, value => {
                            if (value) {
                                console.log('$  save as ' + fileName + ' done! 1@' + tid);
                            } else {
                                console.log('$  ' + fileName + ' already existed! 1@' + tid);
                            }
                        })
                        op.wait();
                    }
                } catch (err) {
                    console.log('$ err: ' + err);
                }
            }
            
            // console.log('leave tj_xxtea_decrypt() f:' + fileName);
        });

        Interceptor.attach(nptr2, {
            onEnter: function(args) {
                // console.log('cc_LZ4_decompress_safe() f:' + this.threadId);
                this.x = args[0];
                this.y = args[1];
                this.z = args[2];
                this.w = args[3];
            },
            onLeave: function(retval) {
                try {
                    const tid = this.threadId;
                    const fileName = worker.get(tid);

                    if (!fileName.endsWith('.png')) {
                        // console.log('	retval: ' + parseInt(retval));
                        // console.log('	y: "' + this.y + ' | ' + this.y.readByteArray(parseInt(retval)) + '"');
                        var code = this.y.readByteArray(parseInt(retval)); // file content
                        send({ path: "/home/khiemnv3/Downloads/LamGame/ThanThuRef_as_prj/frameworks/thanthuv2/frida-server-16.4.8-android-arm64/" + fileName, dump: tid }, code);
                        const op = recv(tid, value => {
                            if (value) {
                                console.log('$  save as ' + fileName + ' done! 2@' + tid);
                            } else {
                                console.log('$  ' + fileName + ' already existed! 2@' + tid);
                            }
                        })
                        op.wait();
                    }
                } catch (err) {
                    console.log('$ err: ' + err);
                }
                // console.log('leave cc_LZ4_decompress_safe() f:' + fileName);
            }
        });
    }
}
var timeout = setTimeout(fn, 500);