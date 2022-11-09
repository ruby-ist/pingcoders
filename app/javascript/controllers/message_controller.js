import {Controller} from "@hotwired/stimulus"


export default class extends Controller {
	static values = {cuser: Number}
	static targets = ["message", "chats"]
	
	connect(){
		this.messageTargets.forEach((message) => {
			if(message.dataset.userId == this.cuserValue){
				message.classList.add('right-message');
			}
		});
		this.scrollToBottom();
	}
	
	scrollToBottom(){
		this.chatsTarget.scrollTop = this.chatsTarget.scrollHeight;
	}
}