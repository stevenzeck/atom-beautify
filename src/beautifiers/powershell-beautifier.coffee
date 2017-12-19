"use strict"
Beautifier = require('./beautifier')

module.exports = class PowerShellBeautifier extends Beautifier
  name: "PowerShell Beautifier"
  link: "https://github.com/DTW-DanWard/PowerShell-Beautifier"

  options: {
    PowerShell: true
  }

  beautify: (text, language, options) ->
    return new @Promise((resolve, reject) =>
      @tempFile("input", text).then((tempFile) ->
        shell = require('node-powershell')
        ps = new shell()
        ps.addCommand("Edit-DTWBeautifyScript -StandardOutput #{tempFile}")
        ps.invoke()
        .then((stdout) ->
          resolve stdout
        )
        .catch (error) ->
          ps.dispose()
          reject new Error(error)
      )
    )
