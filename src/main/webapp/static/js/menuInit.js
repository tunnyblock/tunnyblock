// Custom scripts
$(document).ready(function() {

	// MetsiMenu
	$('#side-menu').metisMenu();

	// minimalize menu
	$('.navbar-minimalize').click(function() {
		$("body").toggleClass("mini-navbar");
		SmoothlyMenu();
	});
	

    // Collapse ibox function
    $('.collapse-link').click( function() {
        var ibox = $(this).closest('div.ibox');
        var button = $(this).find('i');
        var content = ibox.find('div.ibox-content');
        content.slideToggle(200);
        button.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
        ibox.toggleClass('').toggleClass('border-bottom');
        setTimeout(function () {
            ibox.resize();
            ibox.find('[id^=map-]').resize();
        }, 50);
    });

    // Close ibox function
    $('.close-link').click( function() {
        var content = $(this).closest('div.ibox');
        content.remove();
    });
});

// Minimalize menu when screen is less than 768px
$(function() {
	$(window).bind("load resize", function() {
		if ($(this).width() < 769) {
			$('body').addClass('body-small')
		} else {
			$('body').removeClass('body-small')
		}
	})
})

function SmoothlyMenu() {
	if (!$('body').hasClass('mini-navbar') || $('body').hasClass('body-small')) {
		// Hide menu in order to smoothly turn on when maximize menu
		$('#side-menu').hide();
		// For smoothly turn on menu
		setTimeout(function() {
			$('#side-menu').fadeIn(500);
		}, 100);
	} else if ($('body').hasClass('fixed-sidebar')) {
		$('#side-menu').hide();
		setTimeout(function() {
			$('#side-menu').fadeIn(500);
		}, 300);
	} else {
		// Remove all inline style from jquery fadeIn function to reset menu state
		$('#side-menu').removeAttr('style');
	}
}