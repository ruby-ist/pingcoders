import {Controller} from "@hotwired/stimulus"
import $ from "jquery"
import "fomantic-ui"

export default class extends Controller {
	static targets = ["input", "suggestion"];
	static values = { defaultUrl: String }
	
	connect() {
		$('.ui.dropdown').dropdown();
		
		let jInput = $(this.inputTarget);
		let that = this;
		jInput.on("keydown", function(event){
			if(event.keyCode === 13)
				that.getData();
		});
	}
	
	labelTemplate(labels){
		let html = ``;
		for(let i in labels){
			html += `<div class="ui blue label">${labels[i]["name"]}</div>`;
		}
		return html;
	}
	
	cardTemplate(data) {
		let image_url = data["url"];
		if(image_url === '')
			image_url = this.defaultUrlValue;
			
		return `<div class="suggestion" onclick="location.href='/profiles/${data['id']}'">
			<div class="card">
				<div class="content">
					<img class="left floated mini ui circular image" src="${ image_url }">
						<div class="ui medium header">${data["name"]}</div>
				</div>
				<div class="extra content">
					${this.labelTemplate(data["tags"])}
				</div>
			</div>
		</div>`;
	}
	
	async getData() {
		let jInput = $(this.inputTarget);
		let jSuggestion = $(this.suggestionTarget);
		let suggestion = jSuggestion[0];
		let input = jInput[0];
		let type = $('div.text')[0];
		jSuggestion.hide();
		
		if (input.value !== "") {
			jSuggestion.show();
			suggestion.innerHTML = `<div class="ui active blue centered elastic loader"></div>`;
			let response = await fetch(`/search/${encodeURIComponent(input.value)}?type=${type.innerText}`);
			const data = await response.json();
			
			if (data.length === 0) {
				suggestion.innerHTML = `<div class="no-result">No result Found!</div>`;
			} else {
				suggestion.innerHTML = "";
				for (let i = 0; i < data.length; i++)
					suggestion.innerHTML += this.cardTemplate(data[i]);
			}
		}
	}
}