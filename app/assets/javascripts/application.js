// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require gmaps/google
//= require bootstrap/bootstrap.min
//= require bootstrap/typeahead
//= require_tree .

$(document).ready(function() {
  /* typeahead.js categories */
  var categories = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: '/categories/search.json?category=%QUERY'
  });
  categories.initialize();
  $('.category.typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 2
  }, {
    name: 'q',
    displayKey: 'title',
    source: categories.ttAdapter(),
    templates: {
      header: '<li class="header-typeahead">Procure por nome estabelecimento ou palavra-chave</li>'
    }
  });

  /* typeahead.js places */
  var places = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/neighborhoods/search.json?w=%QUERY',
      filter: function(list) {
        return $.map(list, function(address) { return { value: address }; });
      }
    }

  });
  places.initialize();

  $('.place.typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 2
  }, {
    name: 'w',
    displayKey: 'value',
      source: places.ttAdapter(),
      templates: {
        header: '<li class="header-typeahead">Procure por Bairro, CEP, ou Nome de Rua</li>'
      }
    });

});