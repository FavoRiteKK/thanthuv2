/*
 * Auto-generated by Frida. Please modify to match the signature of LZ4_decompress_safe.
 * This stub is currently auto-generated from manpages when available.
 *
 * For full API reference, see: https://frida.re/docs/javascript-api/
 */

{
  /**
   * Called synchronously when about to call LZ4_decompress_safe.
   *
   * @this {object} - Object allowing you to store state for use in onLeave.
   * @param {function} log - Call this function with a string to be presented to the user.
   * @param {array} args - Function arguments represented as an array of NativePointer objects.
   * For example use args[0].readUtf8String() if the first argument is a pointer to a C string encoded as UTF-8.
   * It is also possible to modify arguments by assigning a NativePointer object to an element of this array.
   * @param {object} state - Object allowing you to keep state across function calls.
   * Only one JavaScript function will execute at a time, so do not worry about race-conditions.
   * However, do not use this to store function arguments across onEnter/onLeave, but instead
   * use "this" which is an object for keeping state local to an invocation.
   */
  onEnter(log, args, state) {
    try {
		log('cc_LZ4_decompress_safe()');
		this.x = args[0];
		this.y = args[1];
		this.z = args[2];
		this.w = args[3];
		log('	0: ' + this.x.readCString(20) + ', 1: ' + this.y.readCString(20) + ', 2: ' + this.z + ', 3: ' + this.w);
		log('	fileName: "' + state.fileName.readCString() + '"');
	} catch (err) {
		log('err: ' + err);
	}
  },

  /**
   * Called synchronously when about to return from LZ4_decompress_safe.
   *
   * See onEnter for details.
   *
   * @this {object} - Object allowing you to access state stored in onEnter.
   * @param {function} log - Call this function with a string to be presented to the user.
   * @param {NativePointer} retval - Return value represented as a NativePointer object.
   * @param {object} state - Object allowing you to keep state across function calls.
   */
  onLeave(log, retval, state) {
	  try {
		  // log('	x: "' + this.x + ' | ' + this.x.readCString(100) + '"');
		  log('	y: "' + this.y + ' | ' + this.y.readCString(20) + '"');
		  // log('	z: "' + parseInt(this.z, 16) + /* ' | ' + this.z.readCString() + */ '"');
		  // log('	w: "' + parseInt(this.w, 16)/* .readCString() */ + '"');
		  log('	retval: ' + parseInt(retval));
		  // send({ path: "C:\\LamGame\\frida-server-16.4.8-android-arm64\\tjout.png", dump: "hello" }/* , code */);
	  } catch (err) {
		  log('err: ' + err);
	  }
	  log('leave cc_LZ4_decompress_safe()');
  }
}
