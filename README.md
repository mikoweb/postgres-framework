# PostgreSQL Framework

It's simple framework for PostgreSQL database with unit tests and versioning.

Created based on:

- [PostgreSQL Unit Testing Framework](https://github.com/mixerp/plpgunit)
- [Schema Evolution Manager (sem)](https://github.com/mbryzek/schema-evolution-manager)

## Install framework

    bundle install

## Add script

    bundle exec bin/sem-add-safe ./new-script.sql

## Applying changes to your local database

    bundle exec sem-apply --url postgresql://postgres@localhost/sample --password

## Other commands

Go to [Schema Evolution Manager (sem)](https://github.com/mbryzek/schema-evolution-manager).

## Run tests

    BEGIN TRANSACTION;
    SELECT * FROM unit_tests.begin();
    ROLLBACK TRANSACTION;

## Writing tests

Go to [PostgreSQL Unit Testing Framework](https://github.com/mixerp/plpgunit).

## Uninstall tests

    DROP SCHEMA IF EXISTS assert CASCADE;
    DROP SCHEMA IF EXISTS unit_tests CASCADE;
    DROP DOMAIN IF EXISTS public.test_result CASCADE;

## Uninstall framework

It's' dangerous.

    DROP SCHEMA IF EXISTS framework CASCADE;
