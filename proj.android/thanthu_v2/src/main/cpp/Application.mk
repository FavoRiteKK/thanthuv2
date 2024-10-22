APP_STL := c++_static

APP_CPPFLAGS := -frtti -std=c++11 -fsigned-char -Wno-extern-c-compat
APP_LDFLAGS := -latomic -landroid -llog

APP_ABI := arm64-v8a
APP_SHORT_COMMANDS := true


ifeq ($(NDK_DEBUG),1)
  #APP_CPPFLAGS += -DCOCOS2D_DEBUG=1
  APP_OPTIM := debug
else
  APP_CPPFLAGS += -DNDEBUG
  APP_OPTIM := release
endif