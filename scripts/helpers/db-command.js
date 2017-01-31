const program = require('commander'),
    chalk = require('chalk');

module.exports = {
    /**
     * @param {string} version
     * @return {Command}
     */
    createProgram: function(version) {
        const cmd = program
            .version(version)
            .option('--db_name [type]', 'Database name.')
            .option('--db_user [type]', 'Database user.')
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
    }
};
