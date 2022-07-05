import {Controller} from "@hotwired/stimulus"
import "fomantic-ui"
import "fomantic-ui/toast"


export default class extends Controller {
	static values = {type: String, message: String}
	
	connect() {
		let color;
		if(this.typeValue === "alert")
			color = "red"
		else
			color = "green"
		
		$(this.messageTarget).hide();
		$('body')
			.toast({
				message: this.messageValue,
				class: color,
				className: {
					toast: 'ui message'
				},
				showProgress: 'bottom'
			})
		;
	}
}