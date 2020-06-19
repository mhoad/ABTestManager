module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    }),
    require('postcss-nested'),
    require('postcss-custom-media'),
    require('postcss-selector-not'),
    require('postcss-focus'),
    require('postcss-selector-matches')
  ]
}
