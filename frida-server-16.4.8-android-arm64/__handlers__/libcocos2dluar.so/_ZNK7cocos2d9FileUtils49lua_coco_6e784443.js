/*
 * Auto-generated by Frida. Please modify to match the signature of _ZNK7cocos2d9FileUtils49lua_cocos2dx_ui_Widget_getWorldPosition__VerticalEPNS_15ResizableBufferE.
 * This stub is currently auto-generated from manpages when available.
 *
 * For full API reference, see: https://frida.re/docs/javascript-api/
 */

{
  /**
   * Called synchronously when about to call _ZNK7cocos2d9FileUtils49lua_cocos2dx_ui_Widget_getWorldPosition__VerticalEPNS_15ResizableBufferE.
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
    log('getWorldPosition ');
    this.x = args[0];
    this.y = args[1];
    this.z = args[2];
    this.w = args[3];
    this.t = args[4];
    this.u = args[5];
    this.v = args[6];

    state.fileName = this.w;
    log('x: ' + this.x);
    log('y: ' + this.y.readCString());
    log('z: ' + this.z.readCString());
    log('w: ' + this.w.readCString());
    log('t: ' + this.t);
    log('u: ' + this.u.readCString());
    log('v: ' + this.v);
  },

  /**
   * Called synchronously when about to return from _ZNK7cocos2d9FileUtils49lua_cocos2dx_ui_Widget_getWorldPosition__VerticalEPNS_15ResizableBufferE.
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
		// log('	y: "' + this.y.readCString() + '"');
		// log('	z: "' + this.z + ' | ' + this.z.readCString() + '"');
		log('	w: "' + this.w.readCString() + '"');
		// log(hexdump(this.y, {
			  // offset: 0,
			  // length: 50,
			  // header: false,
			  // ansi: false
		  // }));
		log('	retval: "' + retval + '"');
	} catch (err) {
		log('err: ' + err);
	}
	  log('leave getWorldPosition():');
  }
}
