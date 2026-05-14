#!/bin/zsh

#Safe say function that checks if command exists
function safe_say {
    if command -v say &> /dev/null; then
        say "$1"
    fi
}

#cd to the directory this file is in
DIRECTORY=$(dirname "$0")
cd "$DIRECTORY"

# Dump the address book and replace pipes with tabs
function dump_address_book {

    read "groupName?Please enter a group name, or press Enter for all contacts: "

    if [[ -z "$groupName" ]]; then
        sqlite3 $1 --header "SELECT DISTINCT ZABCDRECORD.ZFIRSTNAME [FIRSTNAME], ZABCDRECORD.ZLASTNAME [LASTNAME], ZABCDPHONENUMBER.ZFULLNUMBER [PHONE], ZABCDEMAILADDRESS.ZADDRESS [EMAIL] FROM ZABCDRECORD LEFT JOIN ZABCDPHONENUMBER ON ZABCDRECORD.Z_PK = ZABCDPHONENUMBER.ZOWNER LEFT JOIN ZABCDEMAILADDRESS ON ZABCDRECORD.Z_PK = ZABCDEMAILADDRESS.ZOWNER WHERE FIRSTNAME IS NOT NULL ORDER BY ZABCDRECORD.ZFIRSTNAME, ZABCDRECORD.ZLASTNAME ASC;" | tr '|' '\t' | tr '+' ' ' | pbcopy
    else
        primaryKey=$(sqlite3 $1 "select Z_PK from ZABCDRecord where ZNAME = '$groupName'");

        sqlite3 $1 --header "SELECT DISTINCT ZABCDRecord.ZFIRSTNAME [FIRSTNAME], ZABCDRECORD.ZLASTNAME [LASTNAME], ZABCDPHONENUMBER.ZFULLNUMBER [PHONE], ZABCDEMAILADDRESS.ZADDRESS [EMAIL] FROM ZABCDRECORD LEFT JOIN ZABCDPHONENUMBER ON ZABCDRECORD.Z_PK = ZABCDPHONENUMBER.ZOWNER LEFT JOIN ZABCDEMAILADDRESS ON ZABCDRECORD.Z_PK = ZABCDEMAILADDRESS.ZOWNER LEFT JOIN Z_22PARENTGROUPS ON ZABCDRECORD.Z_PK = Z_22PARENTGROUPS.Z_22CONTACTS WHERE FIRSTNAME IS NOT NULL AND Z_22PARENTGROUPS.Z_19PARENTGROUPS1 = $primaryKey ORDER BY ZABCDRECORD.ZFIRSTNAME, ZABCDRECORD.ZLASTNAME ASC;" | tr '|' '\t' | tr '+' ' ' | pbcopy
    fi

    echo "Address book copied to clipboard. Paste into Google Sheets."
    safe_say "Done"
}

cd ~/Library/Application\ Support/AddressBook/

# Find the freshest DB that passes an integrity check
db_path=""
for candidate in $(find . -type f -name "AddressBook-v22.abcddb" | xargs ls -tr | tail -r); do
    if sqlite3 "$candidate" "PRAGMA integrity_check;" 2>/dev/null | head -1 | grep -q "^ok$"; then
        db_path="$candidate"
        break
    else
        echo "Skipping corrupt database: $candidate"
    fi
done

if [[ -z "$db_path" ]]; then
    echo "No valid AddressBook database found."
    safe_say "Error"
    exit 1
fi

# 🚨 Dump the address book
dump_address_book $db_path

# Dump whole DB
# sqlite3 $db_path '.dump' > ~/Desktop/dump.sql

#sqlite3 $db_path --header "SELECT * FROM Z_22PARENTGROUPS;"



# 🚨 Examples
# Show tables
# sqlite3 $db_path "SELECT name FROM sqlite_master WHERE type = 'table';"

# How to get columns (unlike select *, this works on an empty table)
#sqlite3 $db_path "PRAGMA table_info(ZABCDCUSTOMPROPERTY);"

# Other examples
#JSON output:
#.mode JSON

#Exit
#.exit

# Known table names:
# ZABCDADDRESSINGGRAMMAR
# ZABCDALERTTONE
# ZABCDCALENDARURI
# ZABCDCONTACTDATE
# ZABCDCONTACTINDEX
# ZABCDCUSTOMPROPERTY
# ZABCDCUSTOMPROPERTYVALUE
# ZABCDDATECOMPONENTS
# ZABCDDELETEDRECORDLOG
# ZABCDDISTRIBUTIONLISTCONFIG
# ZABCDEMAILADDRESS
# ZABCDLIKENESS
# ZABCDMESSAGINGADDRESS
# ZABCDNOTE
# ZABCDPHONENUMBER
# ZABCDPOSTALADDRESS
# ZABCDRECORD
# Z_18PARENTGROUPS
# Z_22PARENTGROUPS
# ZABCDRELATEDNAME
# ZABCDREMOTELOCATION
# ZABCDSERVICE
# ZABCDSOCIALPROFILE
# ZABCDUNKNOWNPROPERTY
# ZABCDURLADDRESS
# ZCNCDCHANGEHISTORYCLIENT
# ZCNCDPROVIDERMETADATA
# ZCNCDUNIFIEDCONTACTINFO
# Z_PRIMARYKEY
# Z_METADATA
# Z_MODELCACHE
# ACHANGE
# ATRANSACTION
# ATRANSACTIONSTRING






