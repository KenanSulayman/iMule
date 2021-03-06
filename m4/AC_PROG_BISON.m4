 
dnl
dnl Check for bison 
dnl AC_PROG_BISON([MIN_VERSION=2.0])
dnl
AC_DEFUN([AC_PROG_BISON], [
if test "x$1" = "x" ; then
    bison_required_version="2.6"
else 
    bison_required_version="$1"
fi

AC_CHECK_PROG(have_prog_bison, [bison], [yes],[no])

AC_DEFINE_UNQUOTED([BISON_VERSION], [0.0],
                   [Defines bison version if bison is not present])

#Do not use *.h extension for parser header file but *.hh
bison_use_parser_h_extension=false

if test "$have_prog_bison" = "yes" ; then
    AC_MSG_CHECKING([for bison version >= $bison_required_version])
    bison_version=`bison --version | head -n 1 | cut '-d ' -f 4`
    AC_DEFINE_UNQUOTED([BISON_VERSION], [$bison_version],
                       [Defines bison version])
    if test "$bison_version" \< "$bison_required_version" ; then
        BISON=:
        AC_MSG_RESULT([no])
        AC_MSG_ERROR([Bison version 2.6 or higher must be installed on the system!])
    else
        AC_MSG_RESULT([yes])
        BISON=bison
        AC_SUBST(BISON)

#Verify automake version
#Upto version 1.11 parser headers for yy files are with h extension, from 1.12 it is hh
        automake_version=`automake --version | head -n 1 | cut '-d ' -f 4`
        AC_DEFINE_UNQUOTED([AUTOMAKE_VERSION], [$automake_version],
                           [Defines automake version])

        if test "$automake_version" \< "1.12" ; then
            #Use *.h extension for parser header file
            bison_use_parser_h_extension=true
            echo "Automake version < 1.12"
            AC_DEFINE([BISON_USE_PARSER_H_EXTENSION], [1],
                      [Use *.h extension for parser header file])
        fi
    fi
else
    BISON=:
    AC_MSG_RESULT([NO])
fi

AM_CONDITIONAL([BISON_USE_PARSER_H_EXTENSION], [test x$bison_use_parser_h_extension = xtrue])
AC_SUBST(BISON)
])
