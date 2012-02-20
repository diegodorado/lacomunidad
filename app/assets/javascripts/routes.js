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
        if (obj[prop]) {
          if (obj[prop] instanceof Array) {
            for (var i=0; i < obj[prop].length; i++) {
              key = prop + encodeURIComponent("[]");
              s.push(key + "=" + encodeURIComponent(obj[prop][i].toString()));
            }
          } else {
            s.push(prop + "=" + encodeURIComponent(obj[prop].toString()));
          }
        }
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

    extract_anchor: function(options) {
      var anchor = options.hasOwnProperty("anchor") ? options.anchor : null;
      delete options.anchor;
      return anchor ? "#" + anchor : "";
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
        throw new Error("Too many parameters provided for path");
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
              throw new Error("Insufficient parameters to build path");
            }
          }
        }
      }
      var format = Utils.extract_format(opts);
      var anchor = Utils.extract_anchor(opts);
      return Utils.clean_path(result + format + anchor) + Utils.serialize(opts);
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
// user_confirmation => /users/confirmation(.:format)
  user_confirmation_path: function(options) {
  return Utils.build_path(0, ["/users/confirmation"], ["format"], arguments)
  },
// new_user_confirmation => /users/confirmation/new(.:format)
  new_user_confirmation_path: function(options) {
  return Utils.build_path(0, ["/users/confirmation/new"], ["format"], arguments)
  },
// users => /users(.:format)
  users_path: function(options) {
  return Utils.build_path(0, ["/users"], ["format"], arguments)
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
// profile => /profile(.:format)
  profile_path: function(options) {
  return Utils.build_path(0, ["/profile"], ["format"], arguments)
  },
// profile_pic => /profile_pic/:provider(.:format)
  profile_pic_path: function(_provider, options) {
  return Utils.build_path(1, ["/profile_pic/"], ["format"], arguments)
  },
// profile_name => /profile_name/:name(.:format)
  profile_name_path: function(_name, options) {
  return Utils.build_path(1, ["/profile_name/"], ["format"], arguments)
  },
// muro => /muro(.:format)
  muro_path: function(options) {
  return Utils.build_path(0, ["/muro"], ["format"], arguments)
  },
// post_comments => /posts/:post_id/comments(.:format)
  post_comments_path: function(_post_id, options) {
  return Utils.build_path(1, ["/posts/", "/comments"], ["format"], arguments)
  },
// post_comment => /posts/:post_id/comments/:id(.:format)
  post_comment_path: function(_post_id, _id, options) {
  return Utils.build_path(2, ["/posts/", "/comments/"], ["format"], arguments)
  },
// vote_post => /posts/:id/vote(.:format)
  vote_post_path: function(_id, options) {
  return Utils.build_path(1, ["/posts/", "/vote"], ["format"], arguments)
  },
// posts => /posts(.:format)
  posts_path: function(options) {
  return Utils.build_path(0, ["/posts"], ["format"], arguments)
  },
// post => /posts/:id(.:format)
  post_path: function(_id, options) {
  return Utils.build_path(1, ["/posts/"], ["format"], arguments)
  },
// opengraph => /opengraph(.:format)
  opengraph_path: function(options) {
  return Utils.build_path(0, ["/opengraph"], ["format"], arguments)
  },
// pages => /pages(.:format)
  pages_path: function(options) {
  return Utils.build_path(0, ["/pages"], ["format"], arguments)
  },
// edit_page => /pages/:id/edit(.:format)
  edit_page_path: function(_id, options) {
  return Utils.build_path(1, ["/pages/", "/edit"], ["format"], arguments)
  },
// page => /pages/:id(.:format)
  page_path: function(_id, options) {
  return Utils.build_path(1, ["/pages/"], ["format"], arguments)
  },
// new_page => /pages/new(.:format)
  new_page_path: function(options) {
  return Utils.build_path(0, ["/pages/new"], ["format"], arguments)
  }}
;
  window.Routes.options = defaults;
})();
