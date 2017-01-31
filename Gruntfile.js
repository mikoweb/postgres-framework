module.exports = function (grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        concat: {
            install: {
                src: [
                    'plpgunit/install/1.install-unit-test.sql'
                ],
                dest: 'scripts/install.sql'
            },
            uninstall: {
                src: [
                    'plpgunit/install/0.uninstall-unit-test.sql'
                ],
                dest: 'scripts/uninstall.sql'
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-concat');

    grunt.registerTask('build', [
        'concat:install',
        'concat:uninstall'
    ]);
};
