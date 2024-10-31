var nptr;
function fn() {
  nptr = Module.findExportByName('libcocos2dluar.so', "_Z16tj_xxtea_decryptPhjS_jPj");
  if (!nptr) {
    console.log("AAsset_read cannot be found!");
    setTimeout(foo, 500);
  } else {
	  console.log("AAsset_read found!");
    Interceptor.attach(nptr, {
      onEnter: function(args) {
          console.log('AAsset_read()');
            this.x = args[0];
            this.y = args[1];
            this.z = args[2];
            this.t = args[3];
            this.u = args[4];
            // console.log('1: "' + this.x.readCString() + '" | ' + this.x + '[end]');
			// File.writeAllBytes("./png", this.x);
			// try {
				// console.log('1: "' + '"');
				// console.log('x: "' + this.x.readCString() + '"');
				// console.log('y: "' + parseInt(this.y, 16) + '"');
				// console.log('z: "' + this.z.readCString() + '"');
				// // console.log('t: "' + this.t + '"');
				// console.log('u: "' + this.u.readInt() + '"');
				// // console.log(hexdump(retval, {
								  // // offset: 0,
								  // // length: 100,
								  // // header: false,
								  // // ansi: false
							  // // }));
			// } catch (err) {
				// console.log('err: ' + err);
			// }
			// console.log(hexdump(this.x, {
						  // offset: 0,
						  // length: 112,
						  // header: true,
						  // ansi: true
					  // }));

        // var len = args[2].toInt32(); // file length
        // var code = args[1].readCString(len); // file content
        // send({ path: args[3].readCString() /* filename */, dump: code });
      }, onLeave: function (retval){
			// try {
				// console.log('2: "' + retval + '"');
				// console.log('x: "' + this.x.readCString() + '"');
				// console.log('y: "' + parseInt(this.y, 16) + '"');
				// console.log('z: "' + this.z.readCString() + '"');
				// // console.log('t: "' + this.t + '"');
				console.log('u: "' + this.u.readInt() + '"');
				// console.log(hexdump(retval, {
								  // offset: 0,
								  // length: this.u.readInt(),
								  // header: false,
								  // ansi: false
							  // }));
			// } catch (err) {
				// console.log('err: ' + err);
			// }
			//-======================
			try {
				// var code = retval.readUtf8String(this.u.readInt());	// file content
				var code = retval.readByteArray(this.u.readInt()); // file content
				// console.log('code: ' + code);
				 send({ path: "C:\\LamGame\\frida-server-16.4.8-android-arm64\\tjout.png" /* filename */ /* , dump: code */ }, code);
			} catch (err) {
				console.log('err: ' + err);
			}
		// console.log('3: "' + this.x.readCString() + '" | ' + '[end]');
		// console.log(hexdump(this.x, {
						  // offset: 0,
						  // length: 112,
						  // header: true,
						  // ansi: true
					  // }));
		}
    })
  }
}
var timeout = setTimeout(fn, 500);