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
// blog_posts => /blog_posts(.:format)
  blog_posts_path: function(options) {
  return Utils.build_path(0, ["/blog_posts"], ["format"], arguments)
  },
// new_blog_post => /blog_posts/new(.:format)
  new_blog_post_path: function(options) {
  return Utils.build_path(0, ["/blog_posts/new"], ["format"], arguments)
  },
// edit_blog_post => /blog_posts/:id/edit(.:format)
  edit_blog_post_path: function(_id, options) {
  return Utils.build_path(1, ["/blog_posts/", "/edit"], ["format"], arguments)
  },
// blog_post => /blog_posts/:id(.:format)
  blog_post_path: function(_id, options) {
  return Utils.build_path(1, ["/blog_posts/"], ["format"], arguments)
  },
// audios => /audios(.:format)
  audios_path: function(options) {
  return Utils.build_path(0, ["/audios"], ["format"], arguments)
  },
// new_audio => /audios/new(.:format)
  new_audio_path: function(options) {
  return Utils.build_path(0, ["/audios/new"], ["format"], arguments)
  },
// edit_audio => /audios/:id/edit(.:format)
  edit_audio_path: function(_id, options) {
  return Utils.build_path(1, ["/audios/", "/edit"], ["format"], arguments)
  },
// audio => /audios/:id(.:format)
  audio_path: function(_id, options) {
  return Utils.build_path(1, ["/audios/"], ["format"], arguments)
  },
// books => /books(.:format)
  books_path: function(options) {
  return Utils.build_path(0, ["/books"], ["format"], arguments)
  },
// new_book => /books/new(.:format)
  new_book_path: function(options) {
  return Utils.build_path(0, ["/books/new"], ["format"], arguments)
  },
// edit_book => /books/:id/edit(.:format)
  edit_book_path: function(_id, options) {
  return Utils.build_path(1, ["/books/", "/edit"], ["format"], arguments)
  },
// book => /books/:id(.:format)
  book_path: function(_id, options) {
  return Utils.build_path(1, ["/books/"], ["format"], arguments)
  },
// videos => /videos(.:format)
  videos_path: function(options) {
  return Utils.build_path(0, ["/videos"], ["format"], arguments)
  },
// new_video => /videos/new(.:format)
  new_video_path: function(options) {
  return Utils.build_path(0, ["/videos/new"], ["format"], arguments)
  },
// edit_video => /videos/:id/edit(.:format)
  edit_video_path: function(_id, options) {
  return Utils.build_path(1, ["/videos/", "/edit"], ["format"], arguments)
  },
// video => /videos/:id(.:format)
  video_path: function(_id, options) {
  return Utils.build_path(1, ["/videos/"], ["format"], arguments)
  },
// votes_result_candidates => /candidates/votes_result(.:format)
  votes_result_candidates_path: function(options) {
  return Utils.build_path(0, ["/candidates/votes_result"], ["format"], arguments)
  },
// votes_reset_candidates => /candidates/votes_reset(.:format)
  votes_reset_candidates_path: function(options) {
  return Utils.build_path(0, ["/candidates/votes_reset"], ["format"], arguments)
  },
// vote_candidate => /candidates/:id/vote(.:format)
  vote_candidate_path: function(_id, options) {
  return Utils.build_path(1, ["/candidates/", "/vote"], ["format"], arguments)
  },
// unvote_candidate => /candidates/:id/unvote(.:format)
  unvote_candidate_path: function(_id, options) {
  return Utils.build_path(1, ["/candidates/", "/unvote"], ["format"], arguments)
  },
// candidates => /candidates(.:format)
  candidates_path: function(options) {
  return Utils.build_path(0, ["/candidates"], ["format"], arguments)
  },
// new_candidate => /candidates/new(.:format)
  new_candidate_path: function(options) {
  return Utils.build_path(0, ["/candidates/new"], ["format"], arguments)
  },
// edit_candidate => /candidates/:id/edit(.:format)
  edit_candidate_path: function(_id, options) {
  return Utils.build_path(1, ["/candidates/", "/edit"], ["format"], arguments)
  },
// candidate => /candidates/:id(.:format)
  candidate_path: function(_id, options) {
  return Utils.build_path(1, ["/candidates/"], ["format"], arguments)
  },
// change_settings => /settings/change(.:format)
  change_settings_path: function(options) {
  return Utils.build_path(0, ["/settings/change"], ["format"], arguments)
  },
// settings => /settings(.:format)
  settings_path: function(options) {
  return Utils.build_path(0, ["/settings"], ["format"], arguments)
  },
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
// docs => /documentos(.:format)
  docs_path: function(options) {
  return Utils.build_path(0, ["/documentos"], ["format"], arguments)
  },
// docs_videos => /documentos/videos(.:format)
  docs_videos_path: function(options) {
  return Utils.build_path(0, ["/documentos/videos"], ["format"], arguments)
  },
// docs_books => /documentos/libros(.:format)
  docs_books_path: function(options) {
  return Utils.build_path(0, ["/documentos/libros"], ["format"], arguments)
  },
// docs_xgs => /documentos/experiencias-guiadas(.:format)
  docs_xgs_path: function(options) {
  return Utils.build_path(0, ["/documentos/experiencias-guiadas"], ["format"], arguments)
  },
// participate => /como-participar(.:format)
  participate_path: function(options) {
  return Utils.build_path(0, ["/como-participar"], ["format"], arguments)
  },
// votes_users => /users/votes(.:format)
  votes_users_path: function(options) {
  return Utils.build_path(0, ["/users/votes"], ["format"], arguments)
  },
// profile_user => /users/:id/profile(.:format)
  profile_user_path: function(_id, options) {
  return Utils.build_path(1, ["/users/", "/profile"], ["format"], arguments)
  },
// toggle_role_user => /users/:id/toggle_role(.:format)
  toggle_role_user_path: function(_id, options) {
  return Utils.build_path(1, ["/users/", "/toggle_role"], ["format"], arguments)
  },
// change_pic_user => /users/:id/change_pic(.:format)
  change_pic_user_path: function(_id, options) {
  return Utils.build_path(1, ["/users/", "/change_pic"], ["format"], arguments)
  },
// change_name_user => /users/:id/change_name(.:format)
  change_name_user_path: function(_id, options) {
  return Utils.build_path(1, ["/users/", "/change_name"], ["format"], arguments)
  },
// users => /users(.:format)
  users_path: function(options) {
  return Utils.build_path(0, ["/users"], ["format"], arguments)
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
// opengraph_api => /opengraph_api(.:format)
  opengraph_api_path: function(options) {
  return Utils.build_path(0, ["/opengraph_api"], ["format"], arguments)
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
  },
// rails_info_properties => /rails/info/properties(.:format)
  rails_info_properties_path: function(options) {
  return Utils.build_path(0, ["/rails/info/properties"], ["format"], arguments)
  }}
;
  window.Routes.options = defaults;
})();
