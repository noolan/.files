#!/bin/bash

cp -r .[a-zA-Z0-9]* ../
cp README ../README

echo '#!/bin/bash
rm -rf ~/.files/
' > /tmp/del.files.sh

chmod +x /tmp/del.files.sh
/tmp/del.files.sh
