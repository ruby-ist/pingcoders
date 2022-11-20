import {Controller} from "@hotwired/stimulus"
import $ from "jquery"

export default class extends Controller {
	static targets = ["input", "suggestion"]
	
	connect() {
		let jInput = $(this.inputTarget);
		let jSuggestion = $(this.suggestionTarget);
		let suggestion = jSuggestion[0];
		let input = jInput[0];
		let that = this;
		let innerChats = ``;
		
		jInput.on("focus", function () {
			if (input.value === "")
				innerChats = suggestion.innerHTML;
		});
		
		jInput.on("keydown", async function (event) {
			if (event.keyCode === 13 && input.value !== "") {
				// alert();
				// let response = await fetch(`/search/${encodeURIComponent(input.value)}?type=Job`);
				// const data = await response.json();
				
				// if (data.length === 0) {
				// 	suggestion.innerHTML = `<div class="no-result">No Match Found!</div>`;
				// 	return;
				// }
				
				$('#posts').load(`/search/${encodeURIComponent(input.value)}?type=Job`);
			}
		});
		
		jInput.on("keyup", function () {
			if(input.value === "")
				suggestion.innerHTML = innerChats;
		});
	}
}