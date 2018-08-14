const { environment } = require('@rails/webpacker');
const typescript =  require('./loaders/typescript');

environment.loaders.append('typescript', typescript);

environment.loaders.append('html', {
    test: /\.html$/,
    use: [{
        loader: 'html-loader',
        options: {
            exportAsEs6Default: 'es6',
            minimize: true,
            collapseWhitespace: true,
            removeAttributeQuotes: false,
            caseSensitive: true,
            customAttrSurround: [ [/#/, /(?:)/], [/\*/, /(?:)/], [/\[?\(?/, /(?:)/] ],
            customAttrAssign: [ /\)?\]?=/ ]
        }
    }]
});

module.exports = environment;
