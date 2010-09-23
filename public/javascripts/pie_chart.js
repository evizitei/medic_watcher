var chart;
$(document).ready(function() {
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container',
			margin: [50, 200, 60, 170]
		},
		title: {
			text: 'City Status (% over all time)'
		},
		plotArea: {
			shadow: null,
			borderWidth: null,
			backgroundColor: null
		},
		tooltip: {
			formatter: function() {
				return '<b>'+ this.point.name +'</b>: '+ this.y +' %';
			}
		},
		plotOptions: {
			pie: {
				allowPointSelect: true,
				cursor: 'pointer',
				dataLabels: {
					enabled: true,
					formatter: function() {
						if (this.y > 5) return this.point.name;
					},
					color: 'white',
					style: {
						font: '13px Trebuchet MS, Verdana, sans-serif'
					}
				}
			}
		},
		legend: {
			layout: 'vertical',
			style: {
				left: 'auto',
				bottom: 'auto',
				right: '50px',
				top: '100px'
			}
		},
	    series: [{
			type: 'pie',
			name: 'City Status',
			data: eval($("#graph_data").html())
		}]
	});
});