const program = require('./helpers/db-command').createProgram('0.0.1'),
    spawn = require('cross-spawn'),
    chalk = require('chalk');

const child = spawn('psql', ['-U', program.db_user, '-d', program.db_name, '-a', '-f', __dirname + '/install.sql']),
    errors = [];

child.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`);
});

child.stderr.on('data', (data) => {
    if (data.indexOf('ERROR:') !== -1) {
        errors.push(data);
        console.log(chalk.red(`stderr: ${data}`));
    } else {
        console.log(chalk.yellow(`stderr: ${data}`));
    }
});

child.on('close', (code) => {
    if (errors.length === 0) {
        console.log(chalk.green('Installation successful.'));
    } else {
        console.log(chalk.red('Occurred ' + errors.length + ' errors.'));
    }
});
