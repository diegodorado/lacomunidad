(function(){

  var defaults = {
    prefix: '',
    format: ''
  };
  
  var Utils = {

    serialize: function(obj){
      if (obj === null) {return '';}
      var s = [];
      for (prop in obj){
        s.push(prop + "=" + encodeURIComponent(obj[prop].toString()));
      }
      if (s.length === 0) {
        return '';
      }
      return "?" + s.join('&');
    },

    clean_path: function(path) {
      return path.replace(/\/+/g, "/").replace(/[\)\(]/g, "").replace(/\.$/m, '').replace(/\/$/m, '');
    },

    extract: function(name, options) {
      var o = undefined;
      if (options.hasOwnProperty(name)) {
        o = options[name];
        delete options[name];
      } else if (defaults.hasOwnProperty(name)) {
        o = defaults[name];
      }
      return o;
    },

    extract_format: function(options) {
      var format = options.hasOwnProperty("format") ? options.format : defaults.format;
      delete options.format;
      return format ? "." + format : "";
    },

    extract_options: function(number_of_params, args) {
      if (args.length > number_of_params) {
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
        return (object.to_param || object.id || object).toString();
      } else {
        return object.toString();
      }
    },

    build_path: function(number_of_params, parts, optional_params, args) {
      args = Array.prototype.slice.call(args);
      var result = Utils.get_prefix();
      var opts = Utils.extract_options(number_of_params, args);
      if (args.length > number_of_params) {
        throw new Error("Too many parameters provided for path")
      }
      var params_count = 0, optional_params_count = 0;
      for (var i=0; i < parts.length; i++) {
        var part = parts[i];
        if (Utils.optional_part(part)) {
          var name = optional_params[optional_params_count];
          optional_params_count++;
          // try and find the option in opts
          var optional = Utils.extract(name, opts);
          if (Utils.specified(optional)) {
            result += part;
            result += Utils.path_identifier(optional);
          }
        } else {
          result += part;
          if (params_count < number_of_params) {
            params_count++;
            var value = args.shift();
            if (Utils.specified(value)) {
              result += Utils.path_identifier(value);
            } else {
              throw new Error("Insufficient parameters to build path")
            }
          }
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
      var prefix = defaults.prefix;

      if( prefix !== "" ){
        prefix = prefix.match('\/$') ? prefix : ( prefix + '/');
      }
      
      return prefix;
    }

  };

  window.Routes = {
// root => /
  root_path: function(options) {
  return Utils.build_path(0, ["/"], [], arguments)
  },
// what => /que-es(.:format)
  what_path: function(options) {
  return Utils.build_path(0, ["/que-es"], ["format"], arguments)
  },
// noticias => /noticias(.:format)
  noticias_path: function(options) {
  return Utils.build_path(0, ["/noticias"], ["format"], arguments)
  },
// documentos => /documentos(.:format)
  documentos_path: function(options) {
  return Utils.build_path(0, ["/documentos"], ["format"], arguments)
  },
// participate => /como-participar(.:format)
  participate_path: function(options) {
  return Utils.build_path(0, ["/como-participar"], ["format"], arguments)
  },
// authentications => /authentications(.:format)
  authentications_path: function(options) {
  return Utils.build_path(0, ["/authentications"], ["format"], arguments)
  },
// new_authentication => /authentications/new(.:format)
  new_authentication_path: function(options) {
  return Utils.build_path(0, ["/authentications/new"], ["format"], arguments)
  },
// edit_authentication => /authentications/:id/edit(.:format)
  edit_authentication_path: function(_id, options) {
  return Utils.build_path(1, ["/authentications/", "/edit"], ["format"], arguments)
  },
// authentication => /authentications/:id(.:format)
  authentication_path: function(_id, options) {
  return Utils.build_path(1, ["/authentications/"], ["format"], arguments)
  },
// new_user_session => /users/sign_in(.:format)
  new_user_session_path: function(options) {
  return Utils.build_path(0, ["/users/sign_in"], ["format"], arguments)
  },
// user_session => /users/sign_in(.:format)
  user_session_path: function(options) {
  return Utils.build_path(0, ["/users/sign_in"], ["format"], arguments)
  },
// destroy_user_session => /users/sign_out(.:format)
  destroy_user_session_path: function(options) {
  return Utils.build_path(0, ["/users/sign_out"], ["format"], arguments)
  },
// user_password => /users/password(.:format)
  user_password_path: function(options) {
  return Utils.build_path(0, ["/users/password"], ["format"], arguments)
  },
// new_user_password => /users/password/new(.:format)
  new_user_password_path: function(options) {
  return Utils.build_path(0, ["/users/password/new"], ["format"], arguments)
  },
// edit_user_password => /users/password/edit(.:format)
  edit_user_password_path: function(options) {
  return Utils.build_path(0, ["/users/password/edit"], ["format"], arguments)
  },
// cancel_user_registration => /users/cancel(.:format)
  cancel_user_registration_path: function(options) {
  return Utils.build_path(0, ["/users/cancel"], ["format"], arguments)
  },
// user_registration => /users(.:format)
  user_registration_path: function(options) {
  return Utils.build_path(0, ["/users"], ["format"], arguments)
  },
// new_user_registration => /users/sign_up(.:format)
  new_user_registration_path: function(options) {
  return Utils.build_path(0, ["/users/sign_up"], ["format"], arguments)
  },
// edit_user_registration => /users/edit(.:format)
  edit_user_registration_path: function(options) {
  return Utils.build_path(0, ["/users/edit"], ["format"], arguments)
  },
// profile => /profile(.:format)
  profile_path: function(options) {
  return Utils.build_path(0, ["/profile"], ["format"], arguments)
  },
// wall_view_more_posts => /muro/mas/:offset(.:format)
  wall_view_more_posts_path: function(_offset, options) {
  return Utils.build_path(1, ["/muro/mas/"], ["format"], arguments)
  },
// muro => /muro(.:format)
  muro_path: function(options) {
  return Utils.build_path(0, ["/muro"], ["format"], arguments)
  },
// create_post_og => /create_post_og(.:format)
  create_post_og_path: function(options) {
  return Utils.build_path(0, ["/create_post_og"], ["format"], arguments)
  },
// new_post => /publicar(.:format)
  new_post_path: function(options) {
  return Utils.build_path(0, ["/publicar"], ["format"], arguments)
  },
// new_comment => /comentar/:post_id(.:format)
  new_comment_path: function(_post_id, options) {
  return Utils.build_path(1, ["/comentar/"], ["format"], arguments)
  },
// wall_view_post_comments => /view_post_comments/:post_id(.:format)
  wall_view_post_comments_path: function(_post_id, options) {
  return Utils.build_path(1, ["/view_post_comments/"], ["format"], arguments)
  },
// wall_vote_post => /vote_post/:post_id/:direction(.:format)
  wall_vote_post_path: function(_post_id, _direction, options) {
  return Utils.build_path(2, ["/vote_post/", "/"], ["format"], arguments)
  },
// pages => /pages(.:format)
  pages_path: function(options) {
  return Utils.build_path(0, ["/pages"], ["format"], arguments)
  },
// new_page => /pages/new(.:format)
  new_page_path: function(options) {
  return Utils.build_path(0, ["/pages/new"], ["format"], arguments)
  },
// edit_page => /pages/:id/edit(.:format)
  edit_page_path: function(_id, options) {
  return Utils.build_path(1, ["/pages/", "/edit"], ["format"], arguments)
  },
// page => /pages/:id(.:format)
  page_path: function(_id, options) {
  return Utils.build_path(1, ["/pages/"], ["format"], arguments)
  }}
;
  window.Routes.options = defaults;
})();
