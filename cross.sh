#!/bin/sh

# Copyright (c) 2012 by Art Clarke
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# It is REQUESTED BUT NOT REQUIRED if you use this library, that you let 
# us know by sending e-mail to info\@xuggle.com telling us briefly how you're
# using the library and what you like or don't like about it.

# First some canonical names we use
VS_WIN32=i686-w64-mingw32
VS_WIN64=x86_64-w64-mingw32
VS_LIN32=i686-pc-linux-gnu
VS_LIN64=x86_64-pc-linux-gnu
VS_MAC32=i386-apple-darwin
VS_MAC64=x86_64-apple-darwin

DIR=$( dirname $0 )
if [ -f "${DIR}/config.guess" ]; then
  HOST=$( "${DIR}/config.guess" )
fi

:> "${DIR}/ant.out"
case $HOST in
  *darwin*)
(ant -Dbuild.configure.os=${VS_MAC32} stage-native | tee -a "${DIR}/ant.out") && \
(ant -Dbuild.configure.os=${VS_MAC64} stage-native | tee -a "${DIR}/ant.out") && \
true
  ;;
  *linux*)
(ant -Dbuild.configure.os=${VS_LIN32} stage-native | tee -a "${DIR}/ant.out") && \
(ant -Dbuild.configure.os=${VS_LIN64} stage-native | tee -a "${DIR}/ant.out") && \
(ant -Dbuild.configure.os=${VS_WIN32} stage-native | tee -a "${DIR}/ant.out") && \
(ant -Dbuild.configure.os=${VS_WIN64} stage-native | tee -a "${DIR}/ant.out") && \
true
  ;;
  *mingw*)
    case $HOST in
      *x86_64*)
(ant -Dbuild.configure.os=${VS_WIN64} stage-native | tee -a "${DIR}/ant.out") && \
true
      ;;
      *)
(ant -Dbuild.configure.os=${VS_WIN32} stage-native | tee -a "${DIR}/ant.out") && \
true
      ;;
    esac
  ;;
esac

