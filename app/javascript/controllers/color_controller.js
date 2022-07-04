import { Controller } from "@hotwired/stimulus"

export default class extends Controller{
  static targets = ["languages"]
  
  async connect() {
    const response = await fetch("/colors");
    const data = await response.json();
    
    let languages = this.languagesTarget.children;
    for(let i=0; i<languages.length; i++){
      let color = data[languages[i].innerHTML];
      if( color !== undefined) {
        languages[i].setAttribute("style", `--border-color: ${color["color"]}; --radient: ${color["color"]}`);
      }
    }
  }
}