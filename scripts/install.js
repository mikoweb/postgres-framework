const psqlCmd = require('./helpers/psql-cmd'),
    program = psqlCmd.createProgram('0.0.1');

const child = psqlCmd.startImport(program, __dirname + '/install.sql');

psqlCmd.execStandardCase(child, 'Installation successful.');
