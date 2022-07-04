import { Controller } from "@hotwired/stimulus"

export default class extends Controller{
	static targets = ["name", "description", "updated", "stars"];
	static values = {username: String, reponame: String};

	
	async connect() {
		function timeSince(date) {
			
			var seconds = Math.floor((new Date() - date) / 1000);
			
			var interval = seconds / 31536000;
			
			if (interval > 1) {
				return Math.floor(interval) + " years";
			}
			interval = seconds / 2592000;
			if (interval > 1) {
				return Math.floor(interval) + " months";
			}
			interval = seconds / 86400;
			if (interval > 1) {
				return Math.floor(interval) + " days";
			}
			interval = seconds / 3600;
			if (interval > 1) {
				return Math.floor(interval) + " hours";
			}
			interval = seconds / 60;
			if (interval > 1) {
				return Math.floor(interval) + " minutes";
			}
			return Math.floor(seconds) + " seconds";
		}
		
		const response = await fetch(`https://api.github.com/repos/${this.usernameValue}/${this.reponameValue}`);
		const data = await response.json();
		this.nameTarget.innerHTML = data["name"];
		this.nameTarget.setAttribute("onclick", `window.open("${data['html_url']}")`);
		if (data["description"] !== null)
			this.descriptionTarget.innerHTML = data["description"];
		
		let time = timeSince(new Date(data["pushed_at"]).getTime());
		this.updatedTarget.innerHTML = `Updated ${time} ago`;

		const stars = await fetch(`https://api.github.com/repos/${this.usernameValue}/${this.reponameValue}/stargazers?per_page=100`);
		const star_data = await stars.json();
		const nos = star_data.length;
		if(nos < 100 ) {
			this.starsTarget.innerHTML = nos;
		}
		else
			this.starsTarget.innerHTML = `100+`;
	}
}