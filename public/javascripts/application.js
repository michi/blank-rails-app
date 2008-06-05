// jQuery plays nicely with Rails' respond_to (http://ozmm.org/posts/jquery_and_respond_to.html)
$.ajaxSetup({ beforeSend: function(xhr){ xhr.setRequestHeader('Accept', 'text/javascript') } });