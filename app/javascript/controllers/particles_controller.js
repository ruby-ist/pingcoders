import {Controller} from "@hotwired/stimulus"
import "jquery-particles"

export default class extends Controller {
	async connect() {
		await loadFull(tsParticles);
		$("#tsparticles").particles().init(
			{
				"background": {
					"color": {
						"value": " #0c0e12"
					},
					"position": "50% 50%",
					"repeat": "no-repeat",
					"size": "cover"
				},
				"fullScreen": {
					"enable": false,
				},
				"interactivity": {
					"events": {
						"onClick": {
							"enable": true,
							"mode": "push"
						},
						"onHover": {
							"enable": true,
							"mode": "slow",
							"parallax": {
								"force": 60
							}
						}
					},
					"modes": {
						"bubble": {
							"distance": 400,
							"duration": 2,
							"opacity": 0.8,
							"size": 40,
							"divs": {
								"distance": 200,
								"duration": 0.4,
								"mix": false,
								"selectors": []
							}
						},
						"grab": {
							"distance": 400
						},
						"repulse": {
							"divs": {
								"distance": 200,
								"duration": 0.4,
								"factor": 100,
								"speed": 1,
								"maxSpeed": 50,
								"easing": "ease-out-quad",
								"selectors": []
							}
						},
						"slow": {
							"radius": 100
						}
					}
				},
				"particles": {
					"color": {
						"value": "#5F85DB"
					},
					"links": {
						"color": {
							"value": "#5F85DB"
						},
						"distance": 150,
						"enable": true,
						"opacity": 0.8
					},
					"move": {
						"attract": {
							"rotate": {
								"x": 60,
								"y": 120
							}
						},
						"enable": true,
						"path": {},
						"outModes": {
							"bottom": "out",
							"left": "out",
							"right": "out",
							"top": "out"
						},
						"speed": 2,
						"spin": {}
					},
					"number": {
						"density": {
							"enable": true
						},
						"value": 60
					},
					"opacity": {
						"value": 0.5,
						"animation": {
							"speed": 1,
							"minimumValue": 0.1
						}
					},
					"size": {
						"value": {
							"min": 1,
							"max": 2
						},
						"animation": {
							"speed": 20,
							"minimumValue": 0.1
						}
					}
				}
			},
		);
	}
}