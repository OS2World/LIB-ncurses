extproc sh

# convert backslashes of PATH to slashes
IFS="\\"
TEMP_PATH=
for dir in $PATH; do
    if test -z "$TEMP_PATH"; then
        TEMP_PATH="$dir"
    else
        TEMP_PATH="$TEMP_PATH/$dir"
    fi
done
PATH="$TEMP_PATH"
export PATH
unset TEMP_PATH

# find a path of ginstall.exe
GINSTALL=${GINSTALL-ginstall.exe}
IFS=";"
for dir in $PATH; do
    if test -x "$dir/$GINSTALL"; then
        GINSTALL="$dir/$GINSTALL"
        break
    fi
done

export ac_executable_extensions=".exe"

CC="gcc.exe" \
CXX="g++.exe" \
CXXFLAGS="-U_XOPEN_SOURCE" \
AWK="gawk.exe" \
INSTALL="$GINSTALL" \
    ./configure --prefix=/usr $@

