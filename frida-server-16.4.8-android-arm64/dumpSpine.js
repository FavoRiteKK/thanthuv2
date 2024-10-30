var nptr1;
var nptr2;
var fileName;

function fn() {
    nptr1 = Module.findExportByName('libcocos2dluar.so', "_ZNK7cocos2d9FileUtils49lua_cocos2dx_ui_Widget_getWorldPosition__VerticalEPNS_15ResizableBufferE");
    nptr2 = Module.findExportByName('libcocos2dluar.so', "LZ4_decompress_safe");
    if (!nptr1 || !nptr2) {
        console.log("AAsset_read cannot be found!");
        setTimeout(foo, 500);
    } else {
        console.log("AAsset_read found!");
        Interceptor.attach(nptr1, {
            onEnter: function(args) {
                console.log('getWorldPosition ');
                this.w = args[3];
                fileName = this.w;
            },
            onLeave: function(retval) {
                try {
                    console.log('	retval: "' + retval + '"');
                } catch (err) {
                    console.log('err: ' + err);
                }
                console.log('leave getWorldPosition():');
            }
        });

        Interceptor.attach(nptr2, {
            onEnter: function(args) {
                console.log('cc_LZ4_decompress_safe()');
                this.x = args[0];
                this.y = args[1];
                this.z = args[2];
                this.w = args[3];
                console.log('	fileName: "' + fileName.readCString() + '"');
            },
            onLeave: function(retval) {
                try {
                    console.log('	retval: ' + parseInt(retval));
                    console.log('	y: "' + this.y + ' | ' + this.y.readByteArray(parseInt(retval)) + '"');
					var code = this.y.readByteArray(parseInt(retval)); // file content
					send({ path: "C:\\LamGame\\frida-server-16.4.8-android-arm64\\tjout.atlas" /* filename */ /* , dump: "hello" */ }, code);
                } catch (err) {
                    console.log('err: ' + err);
                }
                console.log('leave cc_LZ4_decompress_safe()');
            }
        });
    }
}
var timeout = setTimeout(fn, 500);