<%-- 
    Document   : SignUp
    Created on : Jul 1, 2014, 11:13:27 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <link href="pages/resources/select2/select2.css" rel="stylesheet"/>
        <link rel="stylesheet" href="pages/resources/css/jquery-ui-timepicker-addon.css" >
        
        <script src="pages/resources/js/jquery.min.js"></script>
        <script src="pages/resources/select2/select2.js"></script>
        <script type="text/javascript" src="pages/resources/js/jquery-ui.js"></script>
        <script type="text/javascript" src="pages/resources/js/jquery-ui-timepicker-addon.js"></script>
        
        <script>
            
            var cat_json=${cat_list};
            var cat_list=new Array();
            
            $(document).ready(function(){
                $("#dob").datepicker({
           //showSecond: true,
           //timeFormat: 'hh:mm:ss',
           dateFormat:"mm/dd/yy" 
                   });
   for(var i=0; i<cat_json.length; i++)
   {
       cat_list.push({id:cat_json[i]['cid'], text:cat_json[i]['category_name']});
       $("#category").append("<option value="+cat_json[i]['cid']+">"+cat_json[i]['category_name']+"</option>");
   }
    $("#category").select2({
       // multiple: true,
  placeholder:"Select The Categories you are interested in",
  maximumSelectionSize:20
  //allowClear: true,
  //tags: cat_list//[{id: 0, text: 'story'},{id: 1, text: 'bug'},{id: 2, text: 'task'}]
});

  });
  
  function validate()
  {
      var handle=$("#handle").val();
      var email=$("#email").val();
      var country=$("#country").val();
      var state=$("#state").val();
      var city=$("#city").val();
      var zip=$("#zip").val();
      var religion=$("#religion").val();
      var sex=$('input[name=sex]:checked').val();
      var dob=$("#dob").val();
      var phone=$("#phone").val();
      var category=$("#category").val();
      category=JSON.stringify(category);
      $.ajax({
                                type: "POST",       // the dNodeNameefault
                                url: "SignUpReg",
                                data: {handle:handle,email:email,country:country,state:state,city:city,zip:zip,religion:religion,sex:sex,dob:dob,phone:phone,category:category },
                                success: function(data){alert(data);
                                        if(data)
                                        {
                                           
                                        }
                                }
                        });
  }
        </script>
    </head>
    <body>
        
        <div id="fb-root"></div>
        
<script type="text/javascript">

     window.fbAsyncInit = function() {
    FB.init({
      appId      : '555702664544677', // App ID
       status     : true, // check login status
      cookie     : true, // enable cookies to allow the server to access the session
      xfbml      : true  // parse XFBML
    });
    
    
	FB.Event.subscribe('auth.authResponseChange', function(response) 
	{
 	 if (response.status === 'connected') 
  	{
  		document.getElementById("message").innerHTML +=  "<br>Connected to Facebook";
  		//SUCCESS
  		
  	}	 
	else if (response.status === 'not_authorized') 
    {
    	document.getElementById("message").innerHTML +=  "<br>Failed to Connect";

		//FAILED
    } else 
    {
    	document.getElementById("message").innerHTML +=  "<br>Logged Out";

    	//UNKNOWN ERROR
    }
	});	
	
    };
    
   	function Login()
	{
	
		FB.login(function(response) {
		   if (response.authResponse) 
		   {
		    	getUserInfo();
  			} else 
  			{
  	    	 console.log('User cancelled login or did not fully authorize.');
   			}
		 },{scope: 'email,user_photos,user_videos,user_location,user_hometown,user_birthday'});
	

	
	}

  function getUserInfo() {
	    FB.api('/me', function(response) {

	var str="<b>Name</b> : "+response.name+"<br>";
	  	  str +="<b>Link: </b>"+response.link+"<br>";
	  	  str +="<b>Username:</b> "+response.username+"<br>";
	  	  str +="<b>id: </b>"+response.id+"<br>";
	  	  str +="<b>Email:</b> "+response.email+"<br>";
                  
	  	
                  
	  	  str +="<b>Location:</b> "+response.location.name+"<br>";
                  
	  	  str +="<b>Birthday:</b> "+response.birthday+"<br>";
                  
	  	  str +="<b>Gender:</b> "+response.gender+"<br>";
	  	  str +="<input type='button' value='Get Photo' onclick='getPhoto();'/>";
	  	  str +="<input type='button' value='Logout' onclick='Logout();'/>"; 
     document.getElementById("status").innerHTML=str;
     document.getElementById('signUpForm').hidden = false;     
 document.getElementById("imgbut").innerHTML="";
var name = response.name;
var username=response.username;
var userid = response.id;
var email = response.email;
var link = response.link; 
var birthdate = response.birthday;
// assigning begins
document.getElementById("email").value =email;
document.getElementById("email").readOnly = true;
   
document.getElementById("dob").value =birthdate;
document.getElementById("email").readOnly = true;
     
   console.log(name);
    console.log(username);
   console.log(userid);
    console.log(email);
   console.log(link);

       // document.getElementById("details").innerHTML=str;

      //  document.getElementById("status").innerHTML=str2;


	  	  	    
    });
    }
	function getPhoto()
	{
	  FB.api('/me/picture?type=normal', function(response) {

		  var str2 =  "<br/><b>Pic</b> : <img src='"+response.data.url+"'/>";
	  	  document.getElementById("pic").innerHTML=str2;
	  	  	    
    });
	
	}
	function Logout()
	{
		FB.logout(function(){document.location.reload();});
	}

  // Load the SDK asynchronously
  (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
   }(document));
</script>
<div id="status">
    This is really cool <br/></div>
 <div id="details">
     
 </div>
        <div id="imgbut">
<img src="pages/resources/images/LoginWithFacebook.png" style="cursor:pointer;" onclick="Login()"/>
<br/>We respect your hatred towards membership form filling
</div>
<div id="pic"></div>
<br/><br/><br/><br/><br/>
<div id="message">
Logs:<br/>
</div>


<br/>
<br/>
       
        <div id="signUpForm" hidden="true">
             <h1>Fill Up!</h1>
            <table>
                <tr>
                    <td>Handle</td>
                    <td><input type="text" id="handle" name="handle"/></td>
                </tr>
                <tr>
                    <td>Categories</td>
                    <td><select id="category" multiple="multiple" style="width:300px;" tabindex="-1" class="select2-offscreen"></select></td>
                </tr>
                <tr>
                    <td>E-mail</td>
                    <td><input type="text" id="email" name="email"/></td>
                </tr>
                <tr>
                    <td>Country</td>
                    <td><input type="text" id="country" name="country"/></td>
                </tr>
                <tr>
                    <td>State</td>
                    <td><input type="text" id="state" name="state"/></td>
                </tr>
                <tr>
                    <td>City</td>
                    <td><input type="text" id="city" name="city"/></td>
                </tr>
                <tr>
                    <td>Zip</td>
                    <td><input type="text" id="zip" name="zip"/></td>
                </tr>
                <tr>
                    <td>Religion</td>
                    <td><input type="text" id="religion" name="religion"/></td>
                </tr>
                <tr>
                    <td>Sex</td>
                    <td> 
                        <input type="radio"  name="sex" value="M" checked/>Male
                        <input type="radio"  name="sex" value="F"/>Female
                        <input type="radio"  name="sex" value="T"/>Transgender
                        <input type="radio"  name="sex" value="O"/>I do not want to mention
                    </td>
                </tr>
                <tr>
                    <td>Date Of Birth</td>
                    <td></td><td></td><td></td><td></td>
                    <td><input type="text" id="dob" name="dob"/></td>
                </tr>
                <tr>
                    <td>Phone</td>
                    <td><input type="text" id="phone" name="phone"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <button onclick="validate()">Register</button>
                    </td>
                </tr>
            </table>
            </div>
    </body>
</html>