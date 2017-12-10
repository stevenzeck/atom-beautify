'use babel';
let Beautifier;
let PowerShellBeautifier;

Beautifier = require('./beautifier');

export default PowerShellBeautifier = ((() => {

  class PowerShellBeautifier extends Beautifier {

    beautify(text, language, options) {
      return this.tempFile("input", text).then(function(tempFile) {
        const shell = require('node-powershell');
        let ps = new shell();
        ps.addCommand(`Edit-DTWBeautifyScript ${tempFile}`);
        ps.invoke().then(output => {
          this.readFile(tempFile);
        }).catch(err => {
          console.log(err);
          ps.dispose();
        });
      });
    }
    
  };

  PowerShellBeautifier.prototype.name = "PowerShell Beautifier";

  PowerShellBeautifier.prototype.link = "https://github.com/DTW-DanWard/PowerShell-Beautifier";

  PowerShellBeautifier.prototype.options = {
    PowerShell: true
  };

  return PowerShellBeautifier;

}))();
