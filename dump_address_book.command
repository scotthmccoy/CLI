#cd to the directory this file is in
DIRECTORY=$(dirname "$0")
cd "$DIRECTORY"


cd ~/Library/Application\ Support/AddressBook/

# Find the freshest DB
db_path=$(find . -type f -name "AddressBook-v22.abcddb" | xargs ls -tr | tail -n 1)

# Dump the address book and replace pipes with tabs
sqlite3 $db_path "SELECT DISTINCT ZABCDRecord.ZFIRSTNAME [FIRSTNAME], ZABCDRECORD.ZLASTNAME [LASTNAME], ZABCDPHONENUMBER.ZFULLNUMBER [PHONE], ZABCDEMAILADDRESS.ZADDRESS [EMAIL] FROM ZABCDRECORD LEFT JOIN ZABCDPHONENUMBER ON ZABCDRECORD.Z_PK = ZABCDPHONENUMBER.ZOWNER LEFT JOIN ZABCDEMAILADDRESS ON ZABCDRECORD.Z_PK = ZABCDEMAILADDRESS.ZOWNER WHERE FIRSTNAME IS NOT NULL ORDER BY ZABCDRECORD.ZLASTNAME, ZABCDRECORD.ZFIRSTNAME, ZABCDEMAILADDRESS.ZORDERINGINDEX, ZABCDPHONENUMBER.ZORDERINGINDEX ASC;" | tr '|' '\t' | pbcopy

echo "Address book copied to clipboard. Paste into Google Sheets."
say "Done"

#SELECT DISTINCT
#    ZABCDRECORD.ZFIRSTNAME [FIRST NAME],
#    ZABCDRECORD.ZLASTNAME [LAST NAME],
#    ZABCDPHONENUMBER.ZFULLNUMBER [PHONE],
#    ZABCDEMAILADDRESS.ZADDRESS [EMAIL]
#FROM
#    ZABCDRECORD
#    LEFT JOIN ZABCDPHONENUMBER ON ZABCDRECORD.Z_PK = ZABCDPHONENUMBER.ZOWNER
#    LEFT JOIN ZABCDEMAILADDRESS ON ZABCDRECORD.Z_PK = ZABCDEMAILADDRESS.ZOWNER
#ORDER BY
#    ZABCDRECORD.ZLASTNAME,
#    ZABCDRECORD.ZFIRSTNAME,
#    ZABCDEMAILADDRESS.ZORDERINGINDEX,
#    ZABCDPHONENUMBER.ZORDERINGINDEX ASC;
#EOF


#How to SHOW TABLES:
#SELECT name FROM sqlite_master WHERE type = "table"

#Show to SHOW COLUMNS:
#.headers ON
#SELECT * FROM ZABCDEMAILADDRESS LIMIT 5;

#JSON output:
#.mode JSON
#sqlite3 -json database.db "select * from TABLE_NAME"

#Exit
#.exit
