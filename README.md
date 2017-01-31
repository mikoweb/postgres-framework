## Install

    node scripts/install.js --db_name name --db_user user

## Uninstall

    node scripts/uninstall.js --db_name name --db_user user

## Run tests

    --BEGIN TRANSACTION;
    SELECT * FROM unit_tests.begin();
    --ROLLBACK TRANSACTION;
