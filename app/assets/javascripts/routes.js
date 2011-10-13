(function(){

  var Utils = {

    serialize: function(obj){
      if (obj === null) {return '';}
      var s = [];
      for (prop in obj){
        s.push(prop + "=" + obj[prop]);
      }
      if (s.length === 0) {
        return '';
      }
      return "?" + s.join('&');
    },

    clean_path: function(path) {
      return path.replace(/\/+/g, "/").replace(/[\)\(]/g, "").replace(/\.$/m, '').replace(/\/$/m, '');
    },

    extract_format: function(options) {
      var format =  options.hasOwnProperty("format") ? options.format : window.Routes.options.default_format;
      delete options.format;
      return format ? "." + format : "";
    },

    extract_options: function(number_of_params, args) {
      if (args.length >= number_of_params) {
        return typeof(args[args.length-1]) == "object" ?  args.pop() : {};
      } else {
        return {};
      }
    },

    path_identifier: function(object) {
      if (!object) {
        return "";
      }
      if (typeof(object) == "object") {
        return (object.to_param || object.id).toString();
      } else {
        return object.toString();
      }
    },

    build_path: function(number_of_params, parts, args) {
      args = Array.prototype.slice.call(args);
      result = Utils.get_prefix();
      var opts = Utils.extract_options(number_of_params, args);
      for (var i=0; i < parts.length; i++) {
        value = args.shift();
        part = parts[i];
        if (Utils.specified(value)) {
          result += part;
          result += Utils.path_identifier(value);
        } else if (!Utils.optional_part(part)) {
          //TODO: make it strict
          //throw new Error("Can not build path: required parameter is null or undefined.");
          result += part;
        }
      }
      var format = Utils.extract_format(opts);
      return Utils.clean_path(result + format) + Utils.serialize(opts);
    },

    specified: function(value) {
      return !(value === undefined || value === null);
    },

    optional_part: function(part) {
      return part.match(/\(/);
    },

    get_prefix: function(){
      var prefix = window.Routes.options.prefix;

      if( prefix !== "" ){
        prefix = prefix.match('\/$') ? prefix : ( prefix + '/');
      }
      
      return prefix;
    }

  };

  window.Routes = {
// root => /
  root_path: function(options) {
  return Utils.build_path(1, ["/"], arguments)
  },
// authentications => /authentications(.:format)
  authentications_path: function(options) {
  return Utils.build_path(1, ["/authentications"], arguments)
  },
// new_authentication => /authentications/new(.:format)
  new_authentication_path: function(options) {
  return Utils.build_path(1, ["/authentications/new"], arguments)
  },
// edit_authentication => /authentications/:id/edit(.:format)
  edit_authentication_path: function(_id, options) {
  return Utils.build_path(2, ["/authentications/", "/edit"], arguments)
  },
// authentication => /authentications/:id(.:format)
  authentication_path: function(_id, options) {
  return Utils.build_path(2, ["/authentications/"], arguments)
  },
// new_user_session => /users/sign_in(.:format)
  new_user_session_path: function(options) {
  return Utils.build_path(1, ["/users/sign_in"], arguments)
  },
// user_session => /users/sign_in(.:format)
  user_session_path: function(options) {
  return Utils.build_path(1, ["/users/sign_in"], arguments)
  },
// destroy_user_session => /users/sign_out(.:format)
  destroy_user_session_path: function(options) {
  return Utils.build_path(1, ["/users/sign_out"], arguments)
  },
// user_password => /users/password(.:format)
  user_password_path: function(options) {
  return Utils.build_path(1, ["/users/password"], arguments)
  },
// new_user_password => /users/password/new(.:format)
  new_user_password_path: function(options) {
  return Utils.build_path(1, ["/users/password/new"], arguments)
  },
// edit_user_password => /users/password/edit(.:format)
  edit_user_password_path: function(options) {
  return Utils.build_path(1, ["/users/password/edit"], arguments)
  },
// cancel_user_registration => /users/cancel(.:format)
  cancel_user_registration_path: function(options) {
  return Utils.build_path(1, ["/users/cancel"], arguments)
  },
// user_registration => /users(.:format)
  user_registration_path: function(options) {
  return Utils.build_path(1, ["/users"], arguments)
  },
// new_user_registration => /users/sign_up(.:format)
  new_user_registration_path: function(options) {
  return Utils.build_path(1, ["/users/sign_up"], arguments)
  },
// edit_user_registration => /users/edit(.:format)
  edit_user_registration_path: function(options) {
  return Utils.build_path(1, ["/users/edit"], arguments)
  },
// what => /que-es(.:format)
  what_path: function(options) {
  return Utils.build_path(1, ["/que-es"], arguments)
  },
// noticias => /noticias(.:format)
  noticias_path: function(options) {
  return Utils.build_path(1, ["/noticias"], arguments)
  },
// show_news => /noticias/:path(.:format)
  show_news_path: function(_path, options) {
  return Utils.build_path(2, ["/noticias/"], arguments)
  },
// documentos => /documentos(.:format)
  documentos_path: function(options) {
  return Utils.build_path(1, ["/documentos"], arguments)
  },
// participate => /como-participar(.:format)
  participate_path: function(options) {
  return Utils.build_path(1, ["/como-participar"], arguments)
  },
// wall_view_more_posts => /muro/mas/:offset(.:format)
  wall_view_more_posts_path: function(_offset, options) {
  return Utils.build_path(2, ["/muro/mas/"], arguments)
  },
// muro => /muro(.:format)
  muro_path: function(options) {
  return Utils.build_path(1, ["/muro"], arguments)
  },
// create_post_og => /create_post_og(.:format)
  create_post_og_path: function(options) {
  return Utils.build_path(1, ["/create_post_og"], arguments)
  },
// new_post => /publicar(.:format)
  new_post_path: function(options) {
  return Utils.build_path(1, ["/publicar"], arguments)
  },
// new_comment => /comentar/:post_id(.:format)
  new_comment_path: function(_post_id, options) {
  return Utils.build_path(2, ["/comentar/"], arguments)
  },
// wall_view_post_comments => /view_post_comments/:post_id(.:format)
  wall_view_post_comments_path: function(_post_id, options) {
  return Utils.build_path(2, ["/view_post_comments/"], arguments)
  },
// wall_vote_post => /vote_post/:post_id/:direction(.:format)
  wall_vote_post_path: function(_post_id, _direction, options) {
  return Utils.build_path(3, ["/vote_post/", "/"], arguments)
  },
// profile => /profile(.:format)
  profile_path: function(options) {
  return Utils.build_path(1, ["/profile"], arguments)
  },
// pages => /pages(.:format)
  pages_path: function(options) {
  return Utils.build_path(1, ["/pages"], arguments)
  },
// new_page => /pages/new(.:format)
  new_page_path: function(options) {
  return Utils.build_path(1, ["/pages/new"], arguments)
  },
// edit_page => /pages/:id/edit(.:format)
  edit_page_path: function(_id, options) {
  return Utils.build_path(2, ["/pages/", "/edit"], arguments)
  },
// page => /pages/:id(.:format)
  page_path: function(_id, options) {
  return Utils.build_path(2, ["/pages/"], arguments)
  }}
;
  
  window.Routes.options = {
    prefix: '',
    default_format: '',
  };


})();
