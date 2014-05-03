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
//= require raty.min
//= require gmaps/google
//= require bootstrap/bootstrap.min
//= require bootstrap/typeahead
//= require bootstrap/handlebars
//= require_tree .

$(document).ready(function() {

  $('.rating').each(function() {
    $(this).raty({
      readOnly: true,
      half: true,
      score: $(this).data("score"),
      path: '/assets'
    })
  });

  /* typeahead.js categories */
  var categories = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
        url: '/categories/autocomplete.json?q=%QUERY',
        filter: function(list) {
          return $.map(list, function(category) { return { value: category }; });
        }
      }
  });

  var places = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
        url: '/places/autocomplete.json?place=%QUERY',
        filter: function(list) {
          return $.map(list, function(place) { return { value: place }; });
        }
      }
  });

  categories.initialize();
  places.initialize();
  $('.category.typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 2
  }, {
    displayKey: 'value',
    source: categories.ttAdapter(),
    templates: {
      header: '<li class="header-typeahead">Categorias encontradas</li>'
    }
  },
  {
    displayKey: 'value',
    source: places.ttAdapter(),
    templates: {
      header: '<li class="header-typeahead">Estabelecimentos encontrados</li>',
      suggestion: Handlebars.compile('{{value}}')
    }
  });

  /* typeahead.js places */
  var neighborhoods = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/neighborhoods/autocomplete.json?w=%QUERY',
      filter: function(list) {
        return $.map(list, function(address) { return { value: address }; });
      }
    }
  });
  neighborhoods.initialize();

  var address = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/places/autocomplete.json?address=%QUERY',
      filter: function(list) {
        return $.map(list, function(address_value) { return { value: address_value }; });
      }
    }
  });
  address.initialize();

  $('.place.typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 2
  }, {
    displayKey: 'value',
      source: neighborhoods.ttAdapter(),
      templates: {
        header: '<li class="header-typeahead">Bairros encontrados</li>'
      }
    },{
    displayKey: 'value',
      source: address.ttAdapter(),
      templates: {
        header: '<li class="header-typeahead">Endereços encontrados</li>'
      }
    });

});