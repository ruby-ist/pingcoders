import {Controller} from "@hotwired/stimulus"
import $ from "jquery"

export default class extends Controller {
	static targets = ["input", "suggestion"]
	static values = { defaultUrl: String }
	
	connect() {
		let jInput = $(this.inputTarget);
		let jSuggestion = $(this.suggestionTarget);
		let suggestion = jSuggestion[0];
		let input = jInput[0];
		let that = this;
		let innerChats = ``;
		
		jInput.on("focus", function () {
			if(input.value === "")
				innerChats = suggestion.innerHTML;
		});
		
		jInput.on("keydown", function (event) {
			if (event.keyCode === 13) {
				event.preventDefault();
				return;
			}
			if ([37, 39].includes(event.keyCode))
				return;
			if ([38, 40].includes(event.keyCode))
				event.preventDefault();
			
			if(input.value !== "")
				suggestion.innerHTML = `<div class="ui active blue centered elastic loader"></div>`;
			else
				suggestion.innerHTML = innerChats;
		});
		
		jInput.on("keyup", async function (event) {
			if ([37, 38, 39, 40].includes(event.keyCode))
				return;
			
			if (event.keyCode === 13) {
				event.preventDefault();
				return;
			}
			
			if (input.value !== "") {
				let response = await fetch(`/search/${encodeURIComponent(input.value)}?type=Name`);
				const data = await response.json();
				
				if (data.length === 0) {
					suggestion.innerHTML = `<div class="no-result">No Match Found!</div>`;
					return;
				}
				
				suggestion.innerHTML = "";
				for (let i = 0; i < data.length; i++) {
					if (data[i]['url'] === ""){
						data[i]['url'] = that.defaultUrlValue;
					}
					suggestion.innerHTML += `<div class="chat">
												<img class="ui mini avatar image" src="${data[i]['url']}" >
												<a href="/rooms/${data[i]['id']}">
												<div class="username-chat">${data[i]['name']}</div>
												</a>
											</div>`;
				}
			}
		});
	}
}
