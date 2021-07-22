#!/bin/zsh

# Check script options
if [[ "$#" -ne 1 ]]; then
    echo "Usage: ./init.sh MyAddonName"
    exit 1
fi

if [[ $(echo "$1" | head -c 1) == "-" ]]; then
    echo "Usage: ./init.sh MyAddonName"
    exit 1
fi

# Check script necessary tools : sed, perl, perl-rename
PERL=$(command -v perl)
if [[ ! -x "$PERL" ]] ; then
  echo "Install perl"
  exit 1
fi

RENAME=$(command -v perl-rename)
if [[ ! -x "$RENAME" ]] ; then
  RENAME=$(command -v rename)
fi

SED=/usr/bin/sed
if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! [[ -x "$(command -v gsed)" ]]; then
    echo "Install gnu-sed"
    exit 1
  fi
  SED=/usr/local/opt/gnu-sed/libexec/gnubin/sed
fi


ADDON="$1"
ADDON_LC=$(echo $ADDON | $PERL -ne 'print lc')
ADDON_LC_DASHES=$(echo $ADDON_LC | sed 's/_/-/g')

ADDON_DIR="$PWD"
mv "MyOfflineProcess" "$ADDON"
$RENAME "s/my_offline_process/$ADDON_LC/" **/*.{hpp,cpp,txt}
$RENAME "s/MyOfflineProcess/$ADDON/" **/*.{hpp,cpp,txt}
$SED -i "s/my_offline_process/$ADDON_LC/g" **/*.{hpp,cpp}
$SED -i "s/MyOfflineProcess/$ADDON/g" **/*.{hpp,cpp} release.sh
$SED -i "s/my-offline-process/$ADDON_LC_DASHES/g" **/*.{hpp,cpp} release.sh

echo -e "# $ADDON\nA new and wonderful [ossia score](https://ossia.io) add-on" > README.md


find . -name '*.hpp' -exec $PERL -pi -e 'chomp(my $uidgen = `uuidgen`);s|00000000-0000-0000-0000-000000000000|$uidgen|gi' {} \;
find . -name '*.cpp' -exec $PERL -pi -e 'chomp(my $uidgen = `uuidgen`);s|00000000-0000-0000-0000-000000000000|$uidgen|gi' {} \;
find . -name '*.json' -exec $PERL -pi -e 'chomp(my $uidgen = `uuidgen`);s|00000000-0000-0000-0000-000000000000|$uidgen|gi' {} \;
