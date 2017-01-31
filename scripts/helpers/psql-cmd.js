const spawn = require('cross-spawn'),
    program = require('commander'),
    chalk = require('chalk');

module.exports = {
    /**
     * @param {string} version
     * @return {Command}
     */
    createProgram: (version) => {
        const cmd = program
            .version(version)
            .option('--db_name [type]', 'Database name.')
            .option('--db_user [type]', 'Database user.')
            .option('--db_host [type]', 'Database host.')
            .parse(process.argv);

        if (program.db_name === undefined) {
            console.log(chalk.red('Option --db_name is required.'));
            process.exit(1);
        }

        if (program.db_user === undefined) {
            console.log(chalk.red('Option --db_user is required.'));
            process.exit(1);
        }

        return cmd;
    },
    /**
     * @param {Command} program
     * @param {string} file
     * @return {ChildProcess}
     */
    startImport: (program, file) => {
        const options = ['-U', program.db_user, '-d', program.db_name, '-a', '-f', file];

        if (program.db_host !== undefined) {
            options.push('-h', program.db_host);
        }

        return spawn('psql', options);
    },
    /**
     * @param {ChildProcess} child
     * @param {string} successMessage
     * @return {ChildProcess}
     */
    execStandardCase: (child, successMessage) => {
        const errors = [];

        child.stdout.on('data', (data) => {
            console.log(`stdout: ${data}`);
        });

        child.stderr.on('data', (data) => {
            if (data.indexOf('ERROR:') !== -1 || data.indexOf('FATAL:') !== -1) {
                errors.push(data);
                console.log(chalk.red(`stderr: ${data}`));
            } else {
                console.log(chalk.yellow(`stderr: ${data}`));
            }
        });

        child.on('close', (code) => {
            if (errors.length === 0) {
                console.log(chalk.green(successMessage));
            } else {
                console.log(chalk.red('Occurred ' + errors.length + ' errors.'));
            }
        });

        return child;
    }
};
