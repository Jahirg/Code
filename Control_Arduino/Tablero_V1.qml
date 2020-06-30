import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0

Rectangle {
	id: root
	visible: true
	width: 1100
	height: 520
	color: "#969696"

	//####### BOTONES ACTIVACION LEDS############################

	Button {
		id: bt00
		x :10
		y :10
		text: "ON led 13"
		onClicked:{
			if(bt00.text == "ON led 13"){
				Tablero.setLed(13,'H')
				text = "OFF led 13";
			}else
				if(bt00.text == "OFF led 13"){
					Tablero.setLed(13,'L')
					text = "ON led 13";
				}
		}
    }
    
	Button {
		id: bt01
		x : 10
		y : 40
		text: "ON led 12"
		onClicked:{
			if(bt01.text == "ON led 12"){
				Tablero.setLed(12,'H')
				text = "OFF led 12";
			}else
				if(bt01.text == "OFF led 12"){
					Tablero.setLed(12,'L')
					text = "ON led 12";
				}
		}
    }
    
	Button {
		id: bt02
		x : 10
		y : 70
		text: "ON led 11"
		onClicked:{
			if(bt02.text == "ON led 11"){
				Tablero.setLed(11,'H')
				text = "OFF led 11";
			}else
				if(bt02.text == "OFF led 11"){
					Tablero.setLed(11,'L')
					text = "ON led 11";
				}
		}
    }
    
	Button {
		id: bt03
		x : 10
		y : 100
		text: "ON led 10"
		onClicked:{
			if(bt03.text == "ON led 10"){
				Tablero.setLed(10,'H')
				text = "OFF led 10";
			}else
				if(bt03.text == "OFF led 10"){
					Tablero.setLed(10,'L')
					text = "ON led 10";
				}
		}
	}
	
	//####### INDICADORES DE ENTRADAS EN ARDUINO ###########
	
	function actPin6(text) {
		if(text == "611"){
			caja1.color = "#20ff20"
		}
 		else{
			caja1.color = "#969696"
		}
	}

	Rectangle {
		id: caja1
		x : 10
		y : 160
		visible: true
		//width: 70
		//height: 30
		border.width: 2
		border.color: "#969696"
		implicitWidth: 70
		implicitHeight: 30
		radius: 12
		Text {
			id: textp4
			text: "ON P6 "
			font.family: "Helvetica"
			anchors.centerIn: parent
			font.pointSize: 12
			color: "#969696"
		}
	}

	function actPin7(text) {
		if(text == "711"){
			caja2.color = "#20ff20"
		}
 		else{
			caja2.color = "#969696"
			
		}
	}

	Rectangle {
		id: caja2
		x : 10
		y : 200
		visible: true
		border.width: 2
		border.color: "#969696"
		implicitWidth: 70
		implicitHeight: 30
		radius: 12
		Text {
			id: textp5
			text: "ON P7 "
			font.family: "Helvetica"
			anchors.centerIn: parent
			font.pointSize: 12
			color: "#969696"
		}
	}

	function actPin8(text) {
		if(text == "811"){
			caja3.color = "#20ff20"
		}
 		else{
			caja3.color = "#969696"
		}
	}

	Rectangle {
		id: caja3
		x : 10
		y : 240
		visible: true
		border.width: 2
		border.color: "#969696"
		implicitWidth: 70
		implicitHeight: 30
		radius: 12
		Text {
			id: textp6
			text: "ON P8 "
			font.family: "Helvetica"
			anchors.centerIn: parent
			font.pointSize: 12
			color: "#969696"
		}
	}

	function actPin9(text) {
		if(text == "911"){
			caja4.color = "#20ff20"
		}
 		else{
			caja4.color = "#969696"
			
		}
	}

	Rectangle {
		id: caja4
		x : 10
		y : 280
		visible: true
		border.width: 2
		border.color: "#969696"
		implicitWidth: 70
		implicitHeight: 30
		radius: 12
		Text {
			id: textp7
			text: "ON P9 "
			font.family: "Helvetica"
			anchors.centerIn: parent
			font.pointSize: 12
			color: "#969696"
		}
	}

	// ############## GAUGES ################

	function actScale1(text) {
		gauge1.value = (250*text)/1023;
	}
 
	Rectangle {
		id:rect1
		x: 100
		y: 10
		width: 350
		height: 350
		color: "#494d53"
		//color: "#969696"
		CircularGauge {
			id: gauge1
			width: 300
			height: 300
			maximumValue: 250
			anchors.centerIn: parent
			style: CircularGaugeStyle {
				id: style
				labelStepSize: 30

				function degreesToRadians(degrees) {
					return degrees * (Math.PI / 180);
				}

				background: Canvas {
					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();
						ctx.beginPath();
						ctx.strokeStyle = "#ff8000";
						ctx.lineWidth = outerRadius * 0.02;
						ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(120) - 90), degreesToRadians(valueToAngle(250) - 90));
						ctx.stroke();
					}
				}

				tickmark: Rectangle {
					visible: styleData.value < 120 || styleData.value % 10 == 0
					implicitWidth: outerRadius * 0.02
					antialiasing: true
					implicitHeight: outerRadius * 0.06
					color: styleData.value >= 120 ? "#ff8000" : "#e5e5e5"
				}

				minorTickmark: Rectangle {
					visible: styleData.value < 120 || styleData.value % 20 == 0
					implicitWidth: outerRadius * 0.01
					antialiasing: true
					implicitHeight: outerRadius * 0.05
					color: "#e5e5e5"
				}

				tickmarkLabel:  Text {
					font.pixelSize: Math.max(20, outerRadius * 0.09)
					text: styleData.value
					color: styleData.value >= 120 ? "#ff8000" : "#e5e5e5"
					antialiasing: true
				}

				needle: Rectangle {
					y: outerRadius * 0.15
					implicitWidth: outerRadius * 0.03
					implicitHeight: outerRadius * 0.9
					antialiasing: true
					color: "#00ff00"
				}

			}
			Rectangle {
				id:rectsg1
				anchors.horizontalCenter: parent.horizontalCenter
				y: 220
				width: 80
				height: 40
				color: "#494d53"
				Text {
					id:textgauge1
					anchors.horizontalCenter: parent.horizontalCenter
					text: Math.floor(gauge1.value)
					font.family: "Helvetica"
					font.pointSize: 24
					color: "#00ff00"
				}
			}
		}
	}

	function actScale2(text) {
		gauge2.value = (100*text)/1023;
	}

	Rectangle {
		id:rect2
		x: 500
		y: 10
		width: 350
		height: 350
		color: "#494d73"

		CircularGauge {
			id: gauge2
			width: 300
			height: 300
			//value: 75
			anchors.centerIn: parent
			style: CircularGaugeStyle {
				id: style

				function degreesToRadians(degrees) {
					return degrees * (Math.PI / 180);
				}

				background: Canvas {
					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();
						ctx.beginPath();
						ctx.strokeStyle = "#e34c22";
						ctx.lineWidth = outerRadius * 0.02;
						ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(80) - 90), degreesToRadians(valueToAngle(100) - 90));
						ctx.stroke();
					}
				}

				tickmark: Rectangle {
					visible: styleData.value < 80 || styleData.value % 10 == 0
					implicitWidth: outerRadius * 0.02
					antialiasing: true
					implicitHeight: outerRadius * 0.06
					color: styleData.value >= 80 ? "#e34c22" : "#e5e5e5"
				}

				minorTickmark: Rectangle {
					visible: styleData.value < 80
					implicitWidth: outerRadius * 0.01
					antialiasing: true
					implicitHeight: outerRadius * 0.03
					color: "#e5e5e5"
				}

				tickmarkLabel:  Text {
					font.pixelSize: Math.max(6, outerRadius * 0.14)
					text: styleData.value
					color: styleData.value >= 80 ? "#e34c22" : "#e5e5e5"
					antialiasing: true
				}

				needle: Rectangle {
					y: outerRadius * 0.15
					implicitWidth: outerRadius * 0.03
					implicitHeight: outerRadius * 0.9
					antialiasing: true
					color: "#ff8000"
				}

				foreground: Item {
					Rectangle {
						width: outerRadius * 0.2
						height: width
						radius: width / 2
						color: "#e5e5e5"
						anchors.centerIn: parent
					}
				}
			}
			Rectangle {
				id:rectsg2
				anchors.horizontalCenter: parent.horizontalCenter
				y: 220
				width: 80
				height: 40
				color: "#494d73"
				Text {
					id:textgauge2
					anchors.horizontalCenter: parent.horizontalCenter
					text: Math.floor(gauge2.value)
					font.family: "Helvetica"
					font.pointSize: 24
					color: "#FFFF00"
				}
			}

		}
	}

	//####### BARRAS INDICADORAS VERTICALES #####
	function actScale3(text) {
	gauge3.value = (100*text)/1023;
	}

	Gauge {
		id : gauge3
		x : 870
		y : 10
		width: 300
		height: 350
		tickmarkStepSize: 10
		minorTickmarkCount: 1
		font.pixelSize: 18
		style: GaugeStyle {
			valueBar: Rectangle {
				color: "#22e322"
				implicitWidth: 28
			}
			foreground: null
			minorTickmark: Item {
				implicitWidth: 8
				implicitHeight: 2

				Rectangle {
					x: control.tickmarkAlignment === Qt.AlignLeft
					|| control.tickmarkAlignment === Qt.AlignTop ? parent.implicitWidth : -28
					width: 28
					height: parent.height
					color: "#ffffff"
				}
			}
		}
	}

	function actScale4(text) {
	gauge4.value = (gauge4.minimumValue+((gauge4.maximumValue-gauge4.minimumValue)*text)/1023);
	}

	Gauge {
		id : gauge4
		x : 970
		y : 10
		width: 300
		height: 350
		font.pixelSize: 14
		minimumValue: -30
		//value: 70
		maximumValue: 70
		style: GaugeStyle {
			valueBar: Rectangle {
			color: "#1e90ff"
			implicitWidth: 28
			}
		}
	}

	// ####### SLIDERS PARA CONTROL PWM ARDUINO #####
	
	Slider {
		id: slider1
		x:100
		y: 380
		height: 20
		width: 300
		//value: 80
		maximumValue: 255
		stepSize: 5
		tickmarksEnabled : true
		style: SliderStyle {
			groove: Rectangle {
				implicitWidth: 200
				implicitHeight: 8
				color: "gray"
				radius: 8
			}
			handle: Rectangle {
				anchors.centerIn: parent
				color: control.pressed ? "red" : "#ff8080"
				border.color: "gray"
				border.width: 2
				implicitWidth: 24
				implicitHeight: 24
				radius: 12
			}
		}
		Text {
			id: textsl1
			text: Math.floor(slider1.value)
			font.family: "Helvetica"
			x:(slider1.width+20)
			anchors.verticalCenter: parent.verticalCenter
			font.pointSize: 18
			color: "#000000"
		}
		onValueChanged: {Tablero.setPwm("P05",value)}
	}

	Slider {
		id: slider2
		x:100
		y: 420
		height: 20
		width: 300
		//value: 80
		maximumValue: 255
		stepSize: 5
		tickmarksEnabled : true
		style: SliderStyle {
			groove: Rectangle {
				implicitWidth: 200
				implicitHeight: 8
				color: "gray"
				radius: 8
			}
			handle: Rectangle {
				anchors.centerIn: parent
				color: control.pressed ? "#00ff00" : "#90EE90"
				border.color: "gray"
				border.width: 2
				implicitWidth: 24
				implicitHeight: 24
				radius: 12
			}
		}
		Text {
			id: textsl2
			text: Math.floor(slider2.value)
			font.family: "Helvetica"
			x:(slider2.width+20)
			anchors.verticalCenter: parent.verticalCenter
			font.pointSize: 18
			color: "#000000"
		}
		onValueChanged: {Tablero.setPwm("P04",value)}
	}

	
	Slider {
		id: slider3
		x:100
		y: 460
		height: 20
		width: 300
		//value: 80
		maximumValue: 255
		stepSize: 5
		tickmarksEnabled : true
		style: SliderStyle {
			groove: Rectangle {
				implicitWidth: 200
				implicitHeight: 8
				color: "gray"
				radius: 8
			}
			handle: Rectangle {
				anchors.centerIn: parent
				color: control.pressed ? "#0000FF" : "#C0C0FF"
				border.color: "gray"
				border.width: 2
				implicitWidth: 24
				implicitHeight: 24
				radius: 12
			}
		}
		Text {
			id: textsl3
			text: Math.floor(slider3.value)
			font.family: "Helvetica"
			x:(slider3.width+20)
			anchors.verticalCenter: parent.verticalCenter
			font.pointSize: 18
			color: "#000000"
		}
		onValueChanged: {Tablero.setPwm("P03",value)}
	}
	
	Rectangle {
		id: recpwm
		x : 220
		y : 490
		visible: true
		width: 90
		height: 30
		color: "#969696"
		Text {
			id: textpwm
			text: "PWM"
			font.family: "Helvetica"
			anchors.centerIn: parent
			font.pointSize: 24
			color: "#000000"
		}
	}

}
