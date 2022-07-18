import {Controller} from "@hotwired/stimulus"
import $ from "jquery"
import "fomantic-ui"
import "fomantic-ui/sidebar"

export default class extends Controller {
	connect(){
	}
	
	toggle(){
		$('.ui.labeled.icon.sidebar')
			.sidebar('toggle')
		;
	}
}