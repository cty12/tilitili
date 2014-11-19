﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en"> 
    <!-- 
    Smart developers always View Source. 
    
    This application was built using Adobe Flex, an open source framework
    for building rich Internet applications that get delivered via the
    Flash Player or to desktops via Adobe AIR. 
    
    Learn more about Flex at http://flex.org 
    // -->
    <head>
        <title></title>
        <meta name="google" value="notranslate" />         
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!-- Include CSS to eliminate any default margins/padding and set the height of the html element and 
             the body element to 100%, because Firefox, or any Gecko based browser, interprets percentage as 
             the percentage of the height of its parent container, which has to be set explicitly.  Fix for
             Firefox 3.6 focus border issues.  Initially, don't display flashContent div so it won't show 
             if JavaScript disabled.
        -->
        <style type="text/css" media="screen"> 
            html, body  { height:100%; }
            body { margin:0; padding:0; overflow:auto; text-align:center; 
                   background-color: #000000; }   
            object:focus { outline:none; }
            #flashContent { display:none; }
        </style>
        
        <!-- Enable Browser History by replacing useBrowserHistory tokens with two hyphens -->
        <!-- BEGIN Browser History required section -->
        <link rel="stylesheet" type="text/css" href="Player/history/history.css" />
        <script type="text/javascript" src="Player/history/history.js"></script>
        <!-- END Browser History required section -->  
            
        <script type="text/javascript" src="Player/swfobject.js"></script>
        <script type="text/javascript">
            // For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. 
            var swfVersionStr = "11.1.0";
            // To use express install, set to playerProductInstall.swf, otherwise the empty string. 
            var xiSwfUrlStr = "Player/playerProductInstall.swf";
            var flashvars = {};
            flashvars.file = "../uploads/Malaysia_Chabor.flv";
            flashvars.type = "video";
            flashvars.cfile = "danmu/danmu44.xml";
            flashvars.id = "1";
            var params = {};
            params.quality = "high";
            params.bgcolor = "#FFFFFF";
            params.allowscriptaccess = "sameDomain";
            params.allowNetworking = "all"; // 允许SWF调用JS函数
            params.allowfullscreen = "true";
            var attributes = {};
            attributes.id = "MukioPlayerPlus";
            attributes.name = "MukioPlayerPlus";
            attributes.align = "middle";
            swfobject.embedSWF(
                "Player/MukioPlayerPlus.swf", "flashContent", 
                "950", "445", 
                swfVersionStr, xiSwfUrlStr, 
                flashvars, params, attributes);
            // JavaScript enabled so display the flashContent div in case it is not replaced with a swf object.
            swfobject.createCSS("#flashContent", "display:block;text-align:left;");
        </script>
    </head>
    <body>
        <!-- SWFObject's dynamic embed method replaces this alternative HTML content with Flash content when enough 
             JavaScript and Flash plug-in support is available. The div is initially hidden so that it doesn't show
             when JavaScript is disabled.
        -->
        <div id="flashContent">
            <p>
                To view this page ensure that Adobe Flash Player version 
                11.1.0 or greater is installed. 
            </p>
            <script type="text/javascript"> 
                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
            </script> 
        </div>
        
        <noscript>
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="950" height="445" id="MukioPlayerPlus">
                <param name="movie" value="Player/MukioPlayerPlus.swf" />
                <param name="quality" value="high" />
                <param name="bgcolor" value="#000000" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="allowNetworking" value="all" />
                <param name="allowFullScreen" value="true" />
                <!--[if !IE]>-->
                <object type="application/x-shockwave-flash" data="Player/MukioPlayerPlus.swf" width="950" height="445">
                    <param name="quality" value="high" />
                    <param name="bgcolor" value="#000000" />
                    <param name="allowScriptAccess" value="sameDomain" />
                    <param name="allowNetworking" value="all" />
                    <param name="allowFullScreen" value="true" />
                <!--<![endif]-->
                <!--[if gte IE 6]>-->
                    <p> 
                        Either scripts and active content are not permitted to run or Adobe Flash Player version
                        11.1.0 or greater is not installed.
                    </p>
                <!--<![endif]-->
                    <a href="http://www.adobe.com/go/getflashplayer">
                        <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash Player" />
                    </a>
                <!--[if !IE]>-->
                </object>
                <!--<![endif]-->
            </object>
        </noscript>
        <script type="text/javascript">
        	function getDanmu(data) {
        		data.id = "44";
        		var paramString = "did=" + Math.random();
        		for (var x in data) {
        	        paramString += ("&" + x + "=" + data[x]);
        	    }
        	    var xmlhttp;
        	    if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
        	    	xmlhttp=new XMLHttpRequest();
        	    } else { // code for IE6, IE5
        	    	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        	    }
        	    xmlhttp.open("POST","Player/SendDanmu.jsp",true);
        	    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        	    xmlhttp.send(paramString);
        	}
        </script>
   </body>
</html>
