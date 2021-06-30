


let Data = {
	x: 0, y: 0, z: 0, Optional: false,
	reset: function () {
		this.x = 0;
		this.y = 0;
		this.z = 0;
		this.Optional = false
		if (this.Optional == true) {
			$(".in").removeClass('.Z')
		}
	}
}
// if (e.data.type == "openUI" && e.data.data !== null) {
// 	Data.x = e.data.data[0]
// 	Data.y = e.data.data[1]
// 	Data.z = e.data.data[2]
// 	Data.Optional = e.data.data[3]
window.addEventListener('message', function (e) {
	//$("#app").css({ "display": "none" });
	$("#progressbar").css({ "display": "none" });
	//	$.post("https://fx-bug/SendedData", JSON.stringify({ Data }));
	if (e.data.type == "ProgressData") {
		showData(e.data.coords)
	} else if (e.data.type == "exit") {
		Data.reset()
		$("#progressbar").css({ "display": "none" });
		$.post("https://fx-distance/exit", JSON.stringify({}));
	}
})

function showData(position) {
	$("#progressbar").css({ "display": "block" });
	let Posicion = position.toFixed(2)
	$('.text').text('Distance :' + Posicion);
	Posicion > 200 ? $('.text').css({ "background-color": "red" }) : $('.text').css({ "background-color": "green" })
}



