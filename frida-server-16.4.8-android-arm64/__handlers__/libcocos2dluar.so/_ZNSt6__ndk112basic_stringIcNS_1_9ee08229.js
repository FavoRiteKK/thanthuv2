/*
 * Auto-generated by Frida. Please modify to match the signature of _ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm.
 * This stub is currently auto-generated from manpages when available.
 *
 * For full API reference, see: https://frida.re/docs/javascript-api/
 */

{
  /**
   * Called synchronously when about to call _ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm.
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
    log('assign()');
	this.x = args[0];
	this.y = args[1];
	this.z = args[2];
	this.w = args[3];
  },

  /**
   * Called synchronously when about to return from _ZNSt6__ndk112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKcm.
   *
   * See onEnter for details.
   *
   * @this {object} - Object allowing you to access state stored in onEnter.
   * @param {function} log - Call this function with a string to be presented to the user.
   * @param {NativePointer} retval - Return value represented as a NativePointer object.
   * @param {object} state - Object allowing you to keep state across function calls.
   */
  onLeave(log, retval, state) {
	  log('0 <------------------------------------');
	  // log(this.x);
	  log(hexdump(this.y, {
		  offset: 0,
		  length: 112,
		  header: true,
		  ansi: true
	  }));
	  log('1');
	  if (this.y != 0xd68) {
		  log(this.y + ' |y ' + this.y.readCString());
	  }
	  log('2');
	  if (this.z != 0xa) {
		  log(this.z + ' |z ' + this.z.readCString());
	  }
	  log('3');
	  if (this.w != 0x7d7d) {
		  log(this.w + ' |w ' + this.w.readCString());
	  }
	  log('retval');
	  log(retval + ' |r ' + retval.readCString());
  }
}