$(function(){
	$('.icon-pluss').click(function() {
		$('.icon-pluss').toggleClass('active');
	});
	var extensionLists = {}; //Create an object for all extension lists
	extensionLists.video = ['m4v', 'avi','mpg','mp4', 'webm'];  
	extensionLists.image = ['jpg', 'gif', 'bmp', 'png', 'jpeg'];

	// One validation function for all file types    
	window.isValidFileType = function(fName, fType) {
	    console.log('fName: ',fName,'fType: ',fType);
	    return extensionLists[fType].indexOf(fName.split('.').pop()) > -1;
	}
});