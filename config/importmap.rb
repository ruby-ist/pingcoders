# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js"
pin "tsparticles-engine", to: "https://cdn.jsdelivr.net/npm/tsparticles-engine"
pin "tsparticles", to: "https://cdn.jsdelivr.net/npm/tsparticles/tsparticles.bundle.min.js"
pin "jquery-particles", to: "https://cdn.jsdelivr.net/npm/jquery-particles"
pin "fomantic-ui", to: "semantic-ui.js"
pin "fomantic-ui/toast", to: "semantic-ui/toast" # add files in manifest.js first and give different name here