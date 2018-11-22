$(function(){
	$('.icon-pluss').click(function() {
		$('.icon-pluss').toggleClass('active');
	});
	var extensionLists = {}; //Create an object for all extension lists
	extensionLists.video = ['m4v', 'avi','mpg','mp4', 'webm', 'ogv'];  
	extensionLists.image = ['jpg', 'gif', 'bmp', 'png', 'jpeg'];

	// One validation function for all file types    
	window.isValidFileType = function(fName, fType) {
	    console.log('fName: ',fName,'fType: ',fType);
	    return extensionLists[fType].indexOf(fName.split('.').pop().toLocaleLowerCase()) > -1;
	}
	window.UrlExists = function (url) {
	    var http = new XMLHttpRequest();
	    http.open('HEAD', url, false);
	    http.send();
	    return http.status!=404;
	}
});