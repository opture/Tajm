/// <binding BeforeBuild='riot:pages' ProjectOpened='watch:riottags' />
module.exports = function (grunt) {
    'use strict';
    grunt.initConfig({
        // read in the project settings from the package.json file into the pkg property
        pkg: grunt.file.readJSON('package.json')
    });

    //Load grunt tasks automatically.
    require('load-grunt-tasks')(grunt);
    // Configurable paths
    var config = {
        app: 'Scripts/app',
        dist: 'dist',
        pub: 'public'
    };
    grunt.initConfig({
        config: config,
        riot: {
            options: {
                concat: true
            },
            pages: {
                src: 'Scripts/app/tags/**/*.tag',
                dest: 'Scripts/app/tags/tags.js'
            },
        },
        
        // Watches files for changes and runs tasks based on the changed files
        watch: {
            riottags: {
                files: ['<%= config.app %>/tags/{,*/}*.tag'],
                tasks: ['riot'],
                options: {}
            }
        },

    });
};