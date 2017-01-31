const program = require('./helpers/db-command').createProgram('0.0.1'),
    spawn = require('cross-spawn'),
    chalk = require('chalk');

const child = spawn('psql', ['-U', program.db_user, '-d', program.db_name, '-a', '-f', __dirname + '/uninstall.sql'],
    {stdio: 'inherit'});

child.on('exit', (code) => {
    if (code === 0) {
        console.log(chalk.green('Uninstall successful.'));
    } else {
        console.log(chalk.red('Error code: ' + code));
    }
});
