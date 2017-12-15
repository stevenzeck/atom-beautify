"use strict"
Beautifier = require('./beautifier')

module.exports = class PowerShellBeautifier extends Beautifier
  name: "PowerShell Beautifier"
  link: "https://github.com/DTW-DanWard/PowerShell-Beautifier"

  options: {
    PowerShell: true
  }

  beautify: (text, language, options) ->
    @tempFile("input", text).then((tempFile) =>
      shell = require('node-powershell')
      ps = new shell()
      ps.addCommand("Edit-DTWBeautifyScript " + tempFile)
      ps.invoke()
      .then(=>
        @readFile(tempFile)
      )
      .catch (error) ->
        console.log error
        ps.dispose())
