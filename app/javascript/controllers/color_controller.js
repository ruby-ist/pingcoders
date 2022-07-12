import { Controller } from "@hotwired/stimulus"
import tinycolor from "tinycolor2"

export default class extends Controller{
  static targets = ["languages"]
  
  async connect() {
    const response = await fetch("/colors");
    const data = await response.json();
    
    let languages = this.languagesTarget.children;
    for(let i=0; i<languages.length; i++){
      let language = languages[i].children;
      let color = data[language[0].innerHTML];
      if( color !== undefined) {
        if( tinycolor(color["color"]).getBrightness() > 45 )
          languages[i].setAttribute("style", `--border-color: ${color["color"]}; --radient: ${color["color"]}; --text-color: ${color["color"]}`);
        else
          languages[i].setAttribute("style", `--border-color: ${color["color"]}; --radient: ${color["color"]};`);
      }
    }
  }
}