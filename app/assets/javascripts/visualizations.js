var graph = new Graph();
var stationsBuilt = new Data.Hash();

function buildGraph(nodeList, relations) {
	
	$.each(nodeList, function(i, value) {
		var node = graph.newNode({label: value });
		stationsBuilt.set(i, node);
	});
	
	for(var relationIdx in relations) {
		var relationValue = relations[relationIdx];
		
		var firstStation = stationsBuilt.get(relationValue[0]);
		var secondStation = stationsBuilt.get(relationValue[1]);
		var relationText = relationValue[2];
		var relationColor = relationValue[3];
		graph.newEdge(firstStation, secondStation, {color: relationColor});
	}	
}

$(document).ready(function() {
	
	var url = "http://127.0.0.1:9000/graph/representation.json";
	var domGraphAttachElement = "#graph-visualization";
	
	if($.isDefined(domGraphAttachElement)) {
		$.ajax({
				url: url,
		    dataType: 'jsonp',
		    success: function(response) {
					console.log(response);
					buildGraph(response[0], response[1]);
					var springy = jQuery(domGraphAttachElement).springy({
						graph: graph
					});
		    },
		});
		
	}
});