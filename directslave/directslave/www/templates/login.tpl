<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/favicon.ico">

    <title>Login Page</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- Website Font style -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <!-- <link href="/css/ie10-viewport-bug-workaround.css" rel="stylesheet"> -->

    <!-- Custom styles for template -->
    <!-- <link href="/css/dashboard.css" rel="stylesheet"> -->

    <!-- Login form -->
    <link href="/css/loginform.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/js/ie-emulation-modes-warning.js"></script>

    <!-- Google Fonts -->
    <link href='https://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
         <a class="navbar-brand" href="/">{{.Product}}</a>
        </div>
       </div>
    </nav>

<!--
<table width=100% border=0 cellspacing=0 class="header">

<table>
    <tr>
        <td colspan=2 align="center" style="height: 60px; vertical-align: bottom;" valign="bottom">
           <font class=meaasge>{{.Message}}</b>
        </td>
    </tr>
    <tr>
        <td colspan=2 class="text13 black" align=left>
            <br>
            
            <form method=post action="/login">
            Username
            <br><input name=user type=text size=20 maxlength=64 value="{{.User}}" class=field autofocus>
    
            <br><br>
            Password
            <br><input name=pass type=password size=20 maxlength=32 value="{{.Pass}}" class=field>
            
            <input type="hidden" value="Login" name="action">
            
        </td>
    </tr>
    <tr>
        <td align="right"> 
            <input type=submit value="Go!" class="submit">
        </td>
    </tr>
    <tr>
        <td colspan=2 align="center">
            </form><br><br>
        </td>
    
    </tr>
</table>

</div> 
-->
    <div class="container">
        <div class="row main">
            <div class="panel-heading">
               <div class="panel-title text-center">
                    <h1 class="title">Please, login</h1>
                    <hr />
                </div>
            </div> 
            <div class="main-login main-center">
                <form class="form-horizontal" method="post" action="/login">
                    
                    <div class="form-group">
                        <label for="username" class="cols-sm-2 control-label">Username</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
                                <input type="text" class="form-control" name="user" id="username" value="{{.User}}" autofocus/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password" class="cols-sm-2 control-label">Password</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                                <input type="password" class="form-control" name="pass" id="password" value="{{.Pass}}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ">
                        <button type="submit" class="btn btn-primary btn-lg btn-block login-button">Login</button>
                    </div>
                    <div style="text-align: center; font-size: 15pt; color: #E12F2F; font-weight: bold;">{{.Message}}</div>

                    <input type="hidden" value="Login" name="action">
                </form>
            </div>
        </div>
    </div>


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/js/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="/js/jquery.min.js"><\/script>')</script>
    <script src="/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="/js/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</body>
</html>

