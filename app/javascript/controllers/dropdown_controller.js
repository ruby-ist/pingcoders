import {Controller} from "@hotwired/stimulus"
import $ from "jquery"

export default class extends Controller {
	static targets = ["input", "suggestion", "button"]
	static values = {type: String}
	
	connect() {
		let jInput = $(this.inputTarget);
		let jSuggestion = $(this.suggestionTarget);
		let jButton = $(this.buttonTarget);
		let suggestion = jSuggestion[0];
		let input = jInput[0];
		let type = this.typeValue;
		jSuggestion.hide();
		
		function changeInput(element) {
			input.value = element.innerText;
			jButton.removeClass('disabled');
			jButton.focus();
			jSuggestion.hide();
			jInput.removeClass('corner');
		}
		
		jInput.on("focus", function () {
			jButton.addClass('disabled');
		});
		
		$('body:not(.suggestion-box)').on('click', function () {
			jSuggestion.hide();
			jInput.removeClass('corner');
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
			
			let jSelected = $('.selected');
			
			if (event.keyCode === 38) {
				let prev = jSelected.prev();
				if (prev.length) {
					jSelected.removeClass('selected');
					prev.addClass('selected');
				}
				return;
			}
			if (event.keyCode === 40) {
				let next = jSelected.next();
				if (next.length) {
					jSelected.removeClass('selected');
					next.addClass('selected');
				}
				return;
			}
			
			jSuggestion.show();
			jInput.addClass('corner');
			suggestion.innerHTML = `<div class="ui active blue centered elastic loader"></div>`;
		});
		
		jInput.on("keyup", async function (event) {
			if ([37, 38, 39, 40].includes(event.keyCode))
				return;
			
			let jSelected = $('.selected');
			if (event.keyCode === 13) {
				event.preventDefault();
				changeInput(jSelected[0]);
				return;
			}
			
			if (input.value !== "") {
				let response;
				if (type === "language")
					response = await fetch(`/languages?q=${encodeURIComponent(input.value)}`);
				if (type === "skill")
					response = await fetch(`/skills?q=${encodeURIComponent(input.value)}`);
				if (type === "project")
					response = await fetch(`/repos?q=${input.value}`);
				
				const data = await response.json();
				if (data.length === 0) {
					suggestion.innerHTML = `<div class="no-result">No result Found!</div>`;
					return;
				}
				suggestion.innerHTML = "";
				for (let i = 0; i < data.length; i++)
					suggestion.innerHTML += `<div class="suggestion">${data[i]}</div>`;
				
				$('.suggestion:first-child').addClass('selected');
				let jSuggested = $('.suggestion');
				
				jSuggested.hover(function () {
					let jSelected = $('.selected');
					jSelected.removeClass('selected');
					this.classList.add('selected');
				});
				
				jSuggested.click(function () {
					changeInput(this);
				});
			} else {
				jSuggestion.hide();
				jInput.removeClass('corner');
			}
		});
	}
}
