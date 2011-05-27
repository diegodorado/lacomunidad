/*1297738167,169775814*/

if (window.CavalryLogger) { CavalryLogger.start_js(["fNo58"]); }

var ConnectDialog={newInstance:function(h,m,f,e,g,a,j,k,i){var b=new Dialog();var l=new AsyncRequest().setURI('/ajax/profile/connect.php').setData({dialog:1,profile_id:h,source:m,pymk_score:j,pymk_source:k,pymk_page:i}).setFinallyHandler(function(){var n=b.getButtonElement('connect');if(n)n.focus();});for(var d in a)l.setContextData(d,a[d]);b.setAsync(l);var c={ondone_func:f,ondone_data:e,ondone_reload:g,pymk_score:j,pymk_source:k,pymk_page:i};ConnectDialog.prepare(b,c);return b;},prepare:function(a,b){copy_properties(a,b||{});a.setCloseHandler(ConnectDialog.deleteInstance);ConnectDialog.setInstance(a);},deleteInstance:function(){delete ConnectDialog.instance;},setInstance:function(a){ConnectDialog.instance=a;},getInstance:function(){return ConnectDialog.instance;}};

if (window.Bootloader) { Bootloader.done(["fNo58"]); }