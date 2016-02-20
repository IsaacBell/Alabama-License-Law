
function refresh_bookmarks()
{  
  $.ajax({
    url: '/bookmarks',
    type: 'get',
    success: function(bookmarks) {
      ul = $('#bookmarks');
      ul.empty();
      $(bookmarks).each(function(i, b) {
        li = $('<li/>').append($('<a/>')
          .attr('href', '/laws/' + b.law.legal_id)
          .attr('data-fulltitle', b.law.title)
          .addClass('subsection-title')
          .html(b.law.legal_id + " - " + b.law.title.substr(0, 20))
        );
        ul.append(li);
      });
    }
  });
}

$(document).ready(function() {

  $('#browse').sidr({
    onOpen: function() { refresh_bookmarks(); }
  });
  $('#logo').sidr({
    onOpen: function() { refresh_bookmarks(); }
  });
	
	if (window.location.pathname == "/laws") $.sidr('open')
	
	$('.menu-btn').click(function() {
		if ($('body').hasClass('sidr-open')) {
			$.sidr('close')
		} else {
			$.sidr('open')
		}
	});
	
  $("#profile").click(function() {
		$.colorbox({
		  href: '/my-account?return_url=/laws',
		  iframe: true,
		  innerWidth: 200,
		  innerHeight:  50,
		  scrolling: false,
		  transition: 'fade',
		  closeButton: false,
		  onComplete: fix_colorbox,
		  opacity: 0.50   
		});
	});
		
  $("#content .wrapper").click( function(event) {
    //event.preventDefault(); 
    $.sidr('close');
  });
  
  $("#close-sidebar").click( function(event) {
    event.preventDefault(); 
    $.sidr('close');
  });

  // Slide nav and page down on menu click
  $("#top-menu").click(function(event) {
    event.preventDefault(); 
    $("#nav").slideToggle();
    if ( $(window).width() <= 730) {
      var current = $(".content").css("margin");
      if  (current.indexOf("300px") >= 0)  {
        $(".content").animate({ margin: "137px auto 140px auto"}, 400 ); 
      }
      else {
        $(".content").animate({ margin: "300px auto 140px auto"}, 400 ); 
      }
    }
  });

  if ($("#bulb").css("opacity") == 1)
    $("#dark").show();    
    
  // Darken page on light bulb click
  $("#lights").click(function(event) {
    event.preventDefault();
    
    //$("#dark").toggle();
    
    var new_opacity = 0.5;
    if ($("#bulb").css("opacity") == "0.5") // Turned off, so turn on
    {
      new_opacity = 1.0;
      $("#dark").show();
    }
    else // It's currently turned on, so turn off
    {
      new_opacity = 0.5;      
      $("#dark").hide();
    }
    $("#bulb").css("opacity", new_opacity);
      
    $.ajax({
      url: "/bulb",
      type: 'put',
      data: { opacity: new_opacity }
    });
    
    //if ( $("#bulb").css("opacity") == "0.5" ) {
    //  $("#bulb").css("opacity","1.0");
    //}
    //else {
    //  $("#bulb").css("opacity","0.5");
    //}    
  });

  // Increase or decrease font size on magnifying glass click
  $("#magnify").click(function(event) {    
    event.preventDefault();
    var text = $("#wrapper .content");
    if      (text.css('fontSize') == '16px') { text.css({'fontSize':'1.125em'}); }
    else if (text.css('fontSize') == '18px') { text.css({'fontSize':'1.25em'}); }
    else                                     { text.css({'fontSize':'16px'}); }
  });

  // Filter in sidebar
  $("#filter").on('input', function() {
    if ( $("#filter").val().length == 0) {
      $("#sections ul").hide();
      $(".section-title").show();
      $(".subsection-title").show();
    }
    else {
      $(".section-title").hide();
      $(".subsection-title").hide();
      $("#sections ul").show();
      var search = $("#filter").val().toLowerCase(); 
      $(".section-title").each( function() {
        var title = $(this).text().toLowerCase();
        if ( title.indexOf(search) !== -1) {
          $(this).show();
          $(this).siblings().find(".subsection-title").show();
          $(this).next().hide(); 
        }
        $(this).siblings().find(".subsection-title").each( function() {
          var title2 = $(this).data("fulltitle").toLowerCase();
          if ( title2.indexOf(search) !== -1) {
            $(this).closest("ul").show(); 
            $(this).closest("ul").prev().show();
            $(this).show(); 
          }
        });
      });
    }
  });

  // Format law
  function format_law() {
    var letters = 'abcdefghijklmnopqrstuvwxyz';
    //$('.law-content li').each(function (i, ele) {
    //  $('<span />', {
    //    class: "li-head",
    //    html: (function() {
    //      return $(ele).parents('li').addBack().map(function (_, a) {
    //        return isNaN( $(a).parent('ol').attr('type') ) ? letters[$(a).index()] : $(a).index() + 1;
    //      }).get().join('.') + ')&nbsp;';
    //    }())        
    //  }).prependTo(ele);
    //});
    $('p:contains("Statutory Authority:"),p:contains("History:"),p:contains("(Acts "),p:contains("(Act "),p:contains("Cross references"),p:contains("Cross References"),p:contains("See RULE"),p:contains("Author: ")').wrapAll("<div class='law-footer'>");
    $("<hr>").prependTo(".law-footer");
  }
  format_law(); 


  // Display law when clicked in sidebar  
  /*
  $(".subsection-title").click(function(event) {
    event.preventDefault(); 
    var ajax_url = "/laws/get_law/" + $(this).data("id");
    $.get(ajax_url,function(data,status){
      $(".law-content").html( data.content ); 
      $(".law-title").html( data.title ); 
      $(".law-legal_id").html( data.legal_id );
      $.sidr('close');
      $("#nav").slideUp();
      format_law();
      $("html, body").animate({ scrollTop: 0 }, "slow");
    });
  });
  */

  // Sidebar navigation / dropdown lists
  $('ul#sections').delegate('a', 'click', function(event) {
    // event.preventDefault(); 
      if ($(event.target).next().is(':visible')) {
          $(event.target).next().find('ul').slideUp(250, function() {
              $(event.target).next().slideUp(250);
          });
      } else {
          $(event.target).parent().siblings().find("ul").slideUp(250);
          $(event.target).next().slideDown(250);
      }
  });
  $(".section-title").click( function (event) {
    event.preventDefault();
    $(this).toggleClass("expand"); 
    $(this).toggleClass("reduce"); 
    $(this).next().slideToggle(); 
  });


  // Homepage
  $("#login").click(function(event) {
    event.preventDefault(); 
    $("#login-form").slideToggle(); 
  });


  // Change links in law body to go to correct URL 
  $(".law-content a").each(function() {
    //var legal_id = $(this).attr("href");
    //var ajax_url = "/laws/get_law/";
    //$.post(
    //  ajax_url,
    //  {
    //    legal_id: legal_id
    //  },
    //  function(data,status){
    //    if ( data != null ) {
    //      var new_url = "/law/" + data.id;
    //      var legal_id = data.legal_id;
    //      $(".law-content a[href='" + legal_id + "']").attr("href", new_url);
    //    }
    //    else {
    //      $(".law-content a[href='" + legal_id + "']").removeAttr("href"); 
    //    }
    //  }
    //);
    
    var legal_id = $(this).attr("href");
    $.ajax({
      url: "/laws/get-law",
      data: {
        legal_id: legal_id
      },
      success: function(resp) {
        if (resp && resp.id)
          $(".law-content a[href='" + legal_id + "']").attr("href", "/laws/" + resp.id);
        else
          $(".law-content a[href='" + legal_id + "']").removeAttr("href"); 
      }
    });
    
  }); 

  function flash(msg) {
    $("#flash").html(msg); 
    $("#flash").slideDown().delay(3000).slideUp(); 
  }

  // Submit login form
  $("#login-form #right-arrow").click(function(event) {
    login(); 
  });

  function login() {
    if ( $("#login-username").val() == ""){
      flash("Username empty"); 
    }
    else if ($("#login-password").val() == ""){
      flash("Password empty"); 
    }
    else {
      $.post(
        "/login",
        $("#loginform").serialize(),
        function(resp, status) {
          if (resp.error || status == 500) {
            flash("Login error"); 
          }
          else {
            window.location = resp.redirect; 
          }
        }
      );
    }
  }

  $('#login-password').keydown(function (e){
      if(e.keyCode == 13){
          login();
      }
  });

  $('#login-username').keydown(function (e){
      if(e.keyCode == 13){
          login();
      }
  });

  $("#search-submit").click(function(event) {
    event.preventDefault(); 
    $("#menu-search-form").submit(); 
  });

  $("#show_bookmarks").click(function(event){
    event.preventDefault(); 
    $("#sections").toggle(); 
    $("#bookmarks_list").toggle(); 
  });

  $("#show_pages").click(function() {
    $("#sections").show(); 
    $("#bookmarks_list").hide(); 
  });  


}); 


  

  
  

