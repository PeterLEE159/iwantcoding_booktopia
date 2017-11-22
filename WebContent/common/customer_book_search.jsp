<%@page import="kr.go.booktopia.config.Pagination"%>
<%@page import="java.util.Enumeration"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.vo.Genre"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>

	function encodeData(data) {
	    return Object.keys(data).map(function(key) {
	        return [key, data[key]].map(encodeURIComponent).join("=");
	    }).join("&");
	}

	(function() {
		document.getElementById('btn-search').addEventListener('click', function(event) {
			var keyword = document.getElementById('search-keyword').value;
			var opt = document.getElementById('search-opt').value;
			var genre = '';
			var checkboxs = document.querySelectorAll('.genre-selector input');
			var checkSize = checkboxs.length;
			for (var i = 0; i < checkSize; i++) {
				var checkbox = checkboxs[i];
				if (checkbox.checked)
					genre += checkbox.id.replace('genre-', '');
			}
			url = window.location.href;
			if(url.includes("?"))
				url = url.substring(0, url.lastIndexOf("?"));

			url += "?"+encodeData({
				'page': 1,
				'range': 20,
				'keyword': keyword,
				'opt' : opt,
				'genre': genre
			});
			window.location.href = url;
		});
	})();
</script>