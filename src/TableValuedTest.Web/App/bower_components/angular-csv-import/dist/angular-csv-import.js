'use strict';

var csvImport = angular.module('ngCsvImport', []);

csvImport.directive('ngCsvImport', function() {
	return {
		restrict: 'E',
		transclude: true,
		replace: true,
		scope:{
			content:'=?',
			separator: '=?',
			result: '=?',
			encoding: '=?',
			accept: '=?'
		},
		template:
            '<div>' +
			'<div><input class="btn cta gray" type="file" multiple accept="{{accept}}"/></div>' +
			'</div>',
		link: function(scope, element) {
			element.on('change', function(onChangeEvent) {
				var reader = new FileReader();
				scope.filename = onChangeEvent.target.files[0].name;
				reader.onload = function(onLoadEvent) {
					scope.$apply(function() {
						var content = {
							csv: onLoadEvent.target.result.replace(/\r\n|\r/g,'\n'),
						};
						scope.content = content.csv;
						scope.result = csvToJSON(content);
					});
				};

				if ( (onChangeEvent.target.type === "file") && (onChangeEvent.target.files != null || onChangeEvent.srcElement.files != null) )  {
				    reader.readAsText((onChangeEvent.srcElement || onChangeEvent.target).files[0], scope.encoding);				    
				}
			});

			var csvToJSON = function(content) {
				var lines=content.csv.split('\n');
				var result = { "staffIds": []};
				var start = 0;
				var columnCount = lines[0].split(content.separator).length;

				result.projectUid = "2";

				for (var i=start; i<lines.length; i++) {
					var obj = {};
					var currentline=lines[i].split(new RegExp(content.separator+'(?![^"]*"(?:(?:[^"]*"){2})*[^"]*$)'));
					if ( currentline.length === columnCount ) {

					    for (var k = 0; k < currentline.length; k++) {
					        obj[k] = currentline[k];
					    }
					    result.staffIds.push(obj);
					}
				}

				return result;
			};
		}
	};
});