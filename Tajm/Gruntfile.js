/// <binding BeforeBuild='riot:pages' />
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
                src: 'Scripts/app/tags/*.tag',
                dest: 'Scripts/app/tags/tags.js'
                //expand: true,
                //cwd: '<%= config.app %>/tags/',
                //src: '**/*.tag',
                //dest: 'js/tags.js',
                //ext: '.js'
            },
        },
        watch: {
            js: {
                files: ['<%= config.app %>/js/{,*/}*.js'],
                tasks: ['jshint'],
                options: {
                    livereload: true
                }
            },
            riottags: {
                files: ['<%= config.app %>/tags/{,*/}*.tag'],
                tasks: ['riot'],
                options: {
                    livereload: '<%= connect.options.livereload %>'
                }
            },
        }
    });
};