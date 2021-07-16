let volumen = 0.5
window.addEventListener('message', function (e) {
	e.preventDefault();
	$(".Markee").html('<label>Now Playing: </label>')
	$(".Info").html('<label>Volumen: '+volumen)
	if (e.data.data == "open") {
		$(".background").css({ "display": "block" });
	}
})
let song1 = "None"
let Playing = false
$(document).on('click', '.play', function (e) {
	e.preventDefault();
	let song = $(".input").val();
	let IdSong = youtube_parser(song);
$.getJSON('https://noembed.com/embed?url=', { format: 'json', url: song }, function (data) {
			song1 = data.title;
			if (song != null){
				$(".Markee").html('')
				$(".Markee").html('<label>Now Playing: ' + song1 + '</label>')
			 	$('.Markee').marquee();
				 SendData({name:IdSong,track:song,tipo:"Start"})
				 Playing = true
			}
		});
	Spin();
})
$(document).on('click', '.cue', function (e) {
	e.preventDefault();
	let song = $(".input").val();
	if (song != null && Playing == true){
		let IdSong = youtube_parser(song);
		SendData({name:IdSong,track:song,tipo:"Stop"})
	}
	Stop();
})

$(".volumen").draggable({
	axis: "y",
	containment: [0, 480, 0, 664],
	stop:function(event,ui){
		let val = (($('.volumen').offset().top - 480) * 0.3 / 53.5).toFixed(1); //THIS CRAP WORK!
		volumen = val
		$(".Info").html('<label>Volumen: '+volumen)
		let song = $(".input").val();
		if (song != null && Playing == true){
			let IdSong = youtube_parser(song);
		SendData({name:IdSong,vol:val,tipo:"Volumen"})
		}
	},
	// drag: function (event, ui) {
	// 	let val = (($('.volumen').offset().top - 480) * 0.3 / 53.5).toFixed(1); //THIS CRAP WORK!
	// volumen = val
	// $(".Info").html('<label>Volumen: '+volumen)
	// let song = $(".input").val();
	// if (song != null){
	// 	let IdSong = youtube_parser(song);
	// SendData({name:IdSong,vol:val,tipo:"Volumen"})
	// }
	
	// },
});




let jerico = null
function Spin() {
	var angle = 0;
	jerico = setInterval(function () {
		$(".disc")
			.css('-webkit-transform', 'rotate(' + angle + 'deg)')
			.css('-moz-transform', 'rotate(' + angle + 'deg)')
			.css('-ms-transform', 'rotate(' + angle + 'deg)');
		angle++; angle++; angle++;
		angle = angle;
	}, 50);
}
function Stop() {
	$(".Markee").html('');
	$(".Markee").html('<label id="texts">Now Playing:</label>')
	clearInterval(jerico);
	let song = $(".input").val();
	if (song != null){
		let IdSong = youtube_parser(song);
		SendData({name:IdSong,tipo:"Stop"})
	}

}
// $(document).on('click', '#pause', function (e) {
// 	e.preventDefault();
// 	let song = $("#input").val();
// 	let IdSong = youtube_parser(song)
// 	if (song != null) {
// 		$("#information").html('');
// 		$("#markee").html('');

// 		SendData({ name: IdSong, tipo: "Pause" })
// 	}
// });

// $(document).on('click', '#resume', function (e) {
// 	e.preventDefault();
// 	let song = $("#input").val();
// 	let IdSong = youtube_parser(song)
// 	if (song != null) {
// 		SendData({ name: IdSong, tipo: "Resume" })
// 	}
// });
// let volumen = 0.5;
// $(document).on('click', '#volmas', function (e) {
// 	e.preventDefault();
// 	volumen += 0.1;
// 	let song = $("#input").val();
// 	let IdSong = youtube_parser(song)
// 	if (song != null) {
// 		if (volumen < 1.0) {
// 			SendData({ name: IdSong, vol: volumen, tipo: "Volumen" })
// 			$('#information').show();
// 			$('#markee').hide(1);
// 			$("#information").html("");
// 			$("#information").html('<label id="texts">Volumen ' + volumen.toFixed(1) + '</label>');
// 			$('#information').hide(3000, function () {
// 				$('#markee').last().show(100)
// 			})
// 		}

// 	}
// });
// $(document).on('click', '#volmenos', function (e) {
// 	e.preventDefault();
// 	volumen -= 0.1;
// 	let song = $("#input").val();
// 	let IdSong = youtube_parser(song)
// 	if (song != null) {
// 		if (volumen > 0.1) {
// 			SendData({ name: IdSong, vol: volumen, tipo: "Volumen" })
// 			$('#information').show()
// 			$('#markee').hide(1)
// 			$("#information").html("");
// 			$("#information").html('<label id="texts">Volumen ' + volumen.toFixed(1) + '</label>')
// 			$('#information').hide(3000, function () {
// 				$('#markee').last().show(100)
// 			})
// 		}
// 	}
// });


// $(document).on('click', '#stop', function (e) {
// 	e.preventDefault();
// 	volumen -= 0.1;
// 	let song = $("#input").val();
// 	let IdSong = youtube_parser(song)
// 	if (song != null) {
// 		if (volumen > 0.1) {
// 			SendData({ name: IdSong, tipo: "Stop" })
// 			$('#markee').html('')
// 			$("#information").html('<label id="texts">Music Stopped</label>')
// 		}
// 	}
// });

function SendData(tipo) {
	$.post("https://fx-dj/GetMusic", JSON.stringify(tipo))
}

function youtube_parser(url) {
	var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
	var match = url.match(regExp);
	return (match && match[7].length == 11) ? match[7] : false;
}


$(document).on('keydown', function (e) {
	switch (e.keyCode) {
		case 27: // ESCAPE
			$(".background").css({ "display": "none" });
			$.post("https://fx-dj/Exit")
			break;
	}
});

