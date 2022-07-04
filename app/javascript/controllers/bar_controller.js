import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["bar", "list"];
	static values = {username: String, reponame: String}
	
	async connect() {
		const response = await fetch(`https://api.github.com/repos/${this.usernameValue}/${this.reponameValue}/languages`);
		const data = await response.json();
		const colors = await fetch("/colors");
		const color_data = await colors.json();
		
		let sum = 0.0;
		for(let lang in data)
			sum += data[lang];
		
		for(let lang in data) {
			let color = color_data[lang]["color"];
			if (color === undefined)
				color = "#fff";
			let percentage = ((data[lang]/sum)*100).toFixed(2);
			this.barTarget.innerHTML += `<div class="lang" style="--lang-per: ${percentage}% ; --lang-color: ${color};" ></div>`;
			this.listTarget.innerHTML += `<li style=" --lang-color: ${color}; ">${lang}  <span>${percentage}%</span></li>`;
		}
	}
}
